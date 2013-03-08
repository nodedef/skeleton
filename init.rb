ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require File.expand_path("vendor/dependencies/lib/dependencies", File.dirname(__FILE__))
rescue LoadError
  require "dependencies"
end

require "monk/glue"
require 'json'
require "haml"
require "sass"
require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-mysql-adapter'

class Main < Monk::Glue
  set :app_file, __FILE__
  use Rack::Session::Cookie
end


# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

# Connect to mysql.
mysql_db = monk_settings(:mysql)[:database]
mysql_host = monk_settings(:mysql)[:host]
mysql_user = monk_settings(:mysql)[:user]
mysql_password = monk_settings(:mysql)[:password]
db_path = "mysql://#{mysql_user}:#{mysql_password}@#{mysql_host}/#{mysql_db}"
DataMapper.setup(:default, db_path)

Main.run! if Main.run?
