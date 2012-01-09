require 'cgi'

class App
  module Views
    class Flist < Mustache
      @@have=nil
      @@filter
      def filt
	@@filter==true
      end
      def self.have(got)
        @@have=got
      end
      def self.dofilter(params)
	params[:filter].nil? or params[:filter]=="n"
      end
      def self.rows(db, params)
	schema=params[:captures][0]
	table=params[:captures][1]

	data = { "total_undoc" => 0, "total_listing" => 0,
	  "table_schema" => schema, "table_name" => table,
	  "rows" => []}

	schema=db.escape(schema)
	table=db.escape(table)

	if dofilter(params)
	  filter=" AND (status IS NULL OR status NOT LIKE '%#2')"
	  @@filter=true
	else
	  filter=""
	  @@filter=nil
	end

	results=db.query("SELECT COUNT(*) AS undoc FROM field_definitions WHERE table_schema='#{schema}' AND table_name='#{table}'" + filter)
	results.each {|result| data['total_undoc']=result['undoc']}
	results=db.query("SELECT COUNT(*) AS total FROM field_definitions WHERE table_schema='#{schema}' AND table_name='#{table}'")
	results.each {|result| data['total_listing']=result['total']}

	results=db.query("SELECT table_schema, table_name, column_name, notes, CONCAT(table_schema, '.', table_name, '.', column_name) AS tkey FROM field_definitions WHERE table_schema='#{schema}' AND table_name='#{table}'" + filter)
	results.each do |row|

	  data['rows']<< { 'table_schema'=>row["table_schema"],
	    'table_name'=>row["table_name"], 'field_name'=>
	      row["column_name"],
	    'notes'=>row["notes"], 'link'=>
	      "<a href='#{CGI.escape(row["tkey"])}'>Edit</a>",
	    'key'=>row["tkey"] }
	end
	data
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
