class AlfabankGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_initializer
    template "config/initializers/alfabank.rb"
  end
end
