require 'dragonfly'
require 'dragonfly-activerecord/store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "1aefcacb48b8a0d3f9760656720d098f94e9f3472b5661b06ac08d07722c4b00"

  url_format "/media/:job/:name"

  datastore Dragonfly::ActiveRecord::Store.new

  # datastore :file,
  #   root_path: Rails.root.join('public/system/dragonfly', Rails.env),
  #   server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
