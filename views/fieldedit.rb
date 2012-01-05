require 'cgi'

class App
  module Views
    class Fieldedit < Mustache
      @@have=nil
      def self.have(got)
        @@have=got
      end
      def have
        !@@have.nil?
      end
      def got
        @@have
      end
      def self.update(db, record)
	schema=record["schema"]
	table=record["table"]
	column=record["column"]
	notes=record["notes"]
	status=record["status"]
	editable=(record["editable"]=="true" ? 1 : 0)
	key=record["key"]

	results=db.query("UPDATE field_definitions SET notes='#{notes}', status='#{status}', editable='#{editable}' WHERE table_schema='#{schema}' AND table_name='#{table}' AND column_name='#{column}'")
	# Check for error status maybe?
      end
      def self.row(db, params)

      db1=Mysql2::Client.new(:host => 'db0', :username => 'kbarrett',
	:password => File.new("pass","r").gets, :database => params[:splat][0])

	data=nil
	if ! params[:splat].nil?
	  schema=db.escape(params[:splat][0])
	  table=db.escape(params[:splat][1])
	  column=db.escape(params[:splat][2])

	  results=db.query("SELECT notes, status, editable FROM field_definitions WHERE table_schema='#{schema}' AND table_name='#{table}' AND column_name='#{column}'")
	  data={
	    "schema" => schema,
	    "table" => table,
	    "column" => column,
	    "row"=>{},
	    "data"=>[] }
	  results.each do |row|
	    data["row"]=row
	    if row["editable"]==0
	      data["row"]["editable"]=nil
	    else
	      data["row"]["editable"]=true
	    end
	    
	  end
	  p column
	  result=db1.query("SELECT DISTINCT `#{column}` FROM `#{table}` LIMIT 20")
	  result.each do |row|
	    data["data"]<<{"value"=> "<pre style='margin: 0px;'>" << row[column].to_s << "</pre>"}
	  end
	end
	data
      end
    end
  end
end
