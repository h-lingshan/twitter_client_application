require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TwitterClientApplication
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #dveise日本語化をする
    config.i18n.default_locale = :ja
    #表示のみをUST→JSTにする
    config.time_zone = 'Tokyo'
    #DBの保存時間を変更する
    config.active_record.default_timezone = :local

    config.i18n.available_locales = :ja
  end
end
