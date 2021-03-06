require 'sinatra/base'
require 'mustache/sinatra'
require 'cgi'

$: << "./"
class App < Sinatra::Base
  register Mustache::Sinatra
  require 'views/layout'
  require 'views/document'
  require 'views/listing'
  require 'views/flist'
  require 'views/fieldedit'
  require 'mysql2'

  def initialize
    super
    @db=Mysql2::Client.new(:host => 'db0', :username => 'kbarrett',
      :password => File.new("pass","r").gets, :database => 'schema_documentation')
  end

  set :mustache, {
    :views     => 'views/',
    :templates => 'templates/'
  }

  get '/' do
    @title = "Mustache + Sinatra = Wonder"
    mustache :index
  end

  get '/other' do
    mustache :other
  end

  get '/reports/undocumented/tables/mmi' do
    param={"table_schema"=>"mmi1"}

    Views::Listing::have(
      Views::Listing::data(@db, param) )

    mustache :listing
  end

  post '/reports/undocumented/fields/*.*.*' do
    schema=params[:splat][0]
    table=params[:splat][1]
    column=params[:splat][2]

    key=CGI.escape("#{schema}.#{table}.#{column}")
    backlink=CGI.escape("#{schema}.#{table}")

    schema=@db.escape(schema)
    table=@db.escape(table)
    column=@db.escape(column)

    notes=@db.escape(params[:notes])
    status=@db.escape(params[:status])
    editable=@db.escape(params[:editable].to_s)

    record = { "schema" => schema, "table" => table, "column" =>
      column, "notes" => notes, "status" => status, "backlink" =>
      backlink, "editable" => editable, "key" => key }

    Views::Fieldedit::update(@db, record)

    redirect "/reports/undocumented/fields/#{key}"
  end

  get '/reports/undocumented/fields/*.*.*' do
    schema=params[:splat][0]
    table=params[:splat][1]
    column=params[:splat][2]
    key=CGI.escape("#{schema}.#{table}.#{column}")
    backlink=CGI.escape("#{schema}.#{table}")

    data=Views::Fieldedit::row(@db, params)
    data["backlink"]=backlink

    Views::Fieldedit::have ( data ) 
    mustache :fieldedit
  end

  get %r{/reports/undocumented/fields/([\w\s]+)\.([\w\s]+)} do
    data=Views::Flist::rows(@db, params)

    Views::Flist::have ( data )
    mustache :flist
  end

  get '/document*' do
    row = @db.query(
      "select * from to_document" )
    Views::Document::have ( row )
    mustache :document
  end

  get '/nolayout' do
    content_type 'text/plain'
    mustache :nolayout, :layout => false
  end
end
