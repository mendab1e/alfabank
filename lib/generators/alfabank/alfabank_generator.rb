require 'rails/generators/active_record'

class AlfabankGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    template "config/initializers/alfabank.rb"
  end

  def generate_migration
    migration_template("create_table_migration.rb", "db/migrate/create_#{table_name}.rb")
  end

  def generate_model
    template "model.rb", "app/models/#{file_name}.rb"
  end

  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end
end
