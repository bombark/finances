require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Neex
  class Application < Rails::Application

    def database
        if @database.nil?
            @database  = Orientdb4r.client
            @database.connect :database => "PartidoPirata", :user => "root", :password => "root"
        end
        return @database
    end

    def elastic
        #http://www.rubydoc.info/gems/elasticsearch-api/Elasticsearch/API/Actions
        if @elastic.nil?
            @elastic  = Elasticsearch::Client.new url: 'http://localhost:9200'
        end
        return @elastic
    end
  end
end
