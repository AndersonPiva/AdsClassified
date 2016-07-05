require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module ProjetoGrandeOesteClassificados
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.i18n.default_locale = :pt
    config.time_zone = 'Brasilia'
  end
end
