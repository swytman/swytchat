require 'resque_scheduler'
require 'resque/server'

uri = URI.parse("redis://localhost:6379/")  
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.logger = Logger.new 'log/resque.log'
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }