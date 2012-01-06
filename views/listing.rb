class App
  module Views
    class Listing < Mustache
      @@data=
    { "total_undoc" => 65, "total_listing" => 70,
      "table_schema" => 'mmi1', # TODO: document the other schemas
      "rows" => [ ]
    }
      @@have=nil
      def self.data(db, params)
	@@data["table_schema"]=db.escape(params['table_schema'])
# View shows detail of each table that has fields meeting criteria
# for determining undocumented fields in the records mentioned.
	results = db.query("SELECT COUNT(DISTINCT table_name) AS listing FROM field_definitions WHERE table_schema='#{@@data['table_schema']}'")
	results.each do |row|
	  @@data["total_listing"]=row['listing']
	end

	results = db.query("SELECT COUNT(DISTINCT table_name) AS undoc, table_name, column_name FROM field_definitions WHERE (status IS NULL or status NOT LIKE '%#2') AND table_schema='#{@@data['table_schema']}'")
	results.each do |row|
	  @@data["total_undoc"]=row['undoc']
	end
	results = db.query("SELECT DISTINCT table_name FROM field_definitions WHERE (status IS NULL or status NOT LIKE '%#2') AND table_schema='#{@@data['table_schema']}'")
	results.each do |row|
	  doc=nil
	  undoc=nil
	  result={ "table" => row['table_name'] }
	  table_name=db.escape(row['table_name'])
	  results_sub = db.query("SELECT COUNT(*) AS undoc FROM field_definitions WHERE (status IS NULL or status NOT LIKE '%#2') AND table_schema='#{@@data['table_schema']}' AND table_name='#{table_name}'")
	  results_sub.each do |sub|
	    result["undoc"] = sub["undoc"]
	  end
	  results_sub = db.query("SELECT COUNT(*) AS doc FROM field_definitions WHERE NOT (status IS NULL or status NOT LIKE '%#2') AND table_schema='mmi1' AND table_name='#{table_name}'")
	  results_sub.each do |sub|
	    result["doc"] = sub["doc"]
	  end
	  results_sub = db.query("SELECT CONCAT(table_schema, '.', table_name) AS tkey FROM field_definitions WHERE (status IS NULL or status NOT LIKE '%#2') AND table_schema='mmi1' AND table_name='#{table_name}'")
	  results_sub.each do |sub|
	    result["key"] = sub['tkey']
	  end
	  result["total"] = result["doc"] + result["undoc"]
	  @@data["rows"] << result
	end
	@@data["rows"].sort_by! {|hsh| hsh["undoc"]}.reverse!
	h=Hash.new(0)
	@@data["rows"].each do |hash|
	  h["count_doc"] += hash["doc"]
	  h["count_undoc"] += hash["undoc"]
	  h["total_shown"] += hash["doc"]+hash["undoc"]
	end
	@@data.merge(h)
      end
      def self.have(got)
        @@have=got
      end
      def have
        !@@have.nil?
      end
      def got
        @@have
      end
    end
  end
end
