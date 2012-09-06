require 'rails/generators/active_record'

module WebFeed

  class ResourceGenerator < ActiveRecord::Generators::Base
  
    source_root File.expand_path('../templates', __FILE__)

    def generate_migration
      migration_template "migrations/create_resources.rb.erb", "db/migrate/create_#{name.downcase.underscore.pluralize}.rb"
    end

  end

end
