require 'rails/generators/resource_helpers'
require 'rails/generators/migration'
require 'rails/generators'

class Generators::ScaffoldMazer::ScaffoldMazerGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ResourceHelpers
  include Rails::Generators::Migration

  source_root File.expand_path('templates', __dir__)

  class_option :helper, type: :boolean
  class_option :orm, banner: 'NAME', type: :string, required: true, desc: 'ORM to generate the controller for'
  class_option :namespace, type: :string, default: 'admin', aliases: "-n"

  argument :attributes, type: :array, default: [], banner: 'field[:type][:index] field[:type][:index]'

  def create_admin_route
    # puts options['namespace']
    if File.readlines('config/routes.rb').collect(&:chomp).include?("  namespace :#{options['namespace']} do")
      inject_into_file 'config/routes.rb', "    resources :#{plural_name}\n", after: /  namespace :#{options['namespace']} do\n/
    else
      route "namespace :#{options['namespace']} do\n  resources :#{plural_name}\nend\n"
    end
  end

  def create_model
    template 'model.rb.tt', "app/models/#{file_name}.rb"
    migration_template "migration.rb.tt", "db/migrate/create_#{plural_name}.rb"
  end

  def create_admin_controller
    template 'controller.rb.tt', "app/controllers/#{options['namespace']}/#{plural_name}_controller.rb"
  end

  def create_admin_views
    template 'views/_form.html.erb.tt', "app/views/#{options['namespace']}/#{plural_name}/_form.html.erb"
    template 'views/edit.html.erb.tt', "app/views/#{options['namespace']}/#{plural_name}/edit.html.erb"
    template 'views/index.html.erb.tt', "app/views/#{options['namespace']}/#{plural_name}/index.html.erb"
    template 'views/new.html.erb.tt', "app/views/#{options['namespace']}/#{plural_name}/new.html.erb"
    template 'views/show.html.erb.tt', "app/views/#{options['namespace']}/#{plural_name}/show.html.erb"
  end

  def create_sidebar_item
    # inject_into_file "config/locales/#{options['namespace']}_mazer.en.yml", "      #{plural_name}: #{plural_name.humanize}\n", after: /    sidebar:\n/
    # inject_into_file "config/locales/#{options['namespace']}_mazer.en.yml", "      #{plural_name}: \"#{plural_name.humanize}\"\n", after: /    controller:\n/
    # inject_into_file "config/locales/#{options['namespace']}_mazer.en.yml", "    #{file_name}:\n      new: \"New #{file_name}\"\n      listing: \"Listing #{plural_name}\"\n      edit: \"Edit #{file_name}\"\n      show: \"Show #{file_name}\"\n", before: /    controller:\n/
    i = begin
          File.readlines("app/views/mazer_partials/layout/_#{options['namespace']}_sidebar.html.erb").collect(&:squish).join.scan(/sidebar_value: ([0-9]+)\,/i).flatten.max.to_i + 1
        rescue StandartError => e
          0
        end
    i -= 1 if self.behavior == :revoke
    # sidebar_active = "{sidebar_active_to_class(savalue, #{i})}"
    # inject_into_file 'app/views/mazer_partials/layout/_admin_sidebar.html.erb', before: /      <\/ul>\n    <\/nav>\n/ do
    #   "        <li class=\"nav-item\">
    #       <%= link_to admin_#{plural_name}_path, class: \"nav-link ##{sidebar_active}\" do %>
    #         <i class=\"nav-icon fas fa-chevron-right\"></i>
    #         <p><%= t 'lte.sidebar.#{plural_name}' %></p>
    #       <% end %>
    #     </li>\n"
    inject_into_file 'app/views/mazer_partials/layout/_admin_sidebar.html.erb', before: /      <\/ul> <%# scaffold_mazer insert - do not remove this comment %>/ do
        "        <%= render partial: 'mazer_partials/layout/sidebar_item', locals: {
          current_sidebar_value: savalue,
          current_sidebar_sub_value: sub_savalue,
          title: #{class_name.demodulize}.model_name.human(count: 0),
          sidebar_value: #{i},
          url: admin_#{plural_name}_path,
          icon: 'fas fa-chevron-right',
        } %>\n"
    end
    inject_into_file 'app/helpers/mazer/sidebar_helper.rb', "      when 'admin/#{plural_name}'\n        #{i}\n", before: "        # scaffold_mazer #{options['namespace']} insert"
  end

  def create_rspec_factories
    template 'rspec/factories/factory.rb.tt', "spec/factories/#{plural_name}.rb"
  end

  def create_rspec_models
    template 'rspec/models/model_spec.rb.tt', "spec/models/#{plural_name}_spec.rb"
  end

  def create_rspec_system
    template 'rspec/system/system_spec.rb.tt', "spec/system/#{options['namespace']}/#{plural_name}/#{plural_name}_spec.rb"
  end

  private

  def primary_key_type
    key_type = options[:primary_key_type]
    ", id: :#{key_type}" if key_type
  end

  def attributes_with_index
    attributes.select { |a| !a.reference? && a.has_index? }
  end

  def self.next_migration_number(dir)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

end
