require 'rails/railtie'

module Transit
  module Rails
    class Railtie < ::Rails::Railtie
      config.after_initialize do
        require 'transit/rails/renderer'
        require 'action_controller/metal/renderers'

        Mime::Type.register "application/transit+json", :transit
        Mime::Type.register_alias "application/transit+json", :transit_verbose
        Mime::Type.register "application/transit+msgpack", :transit_msgpack

        ActionController.add_renderer :transit do |obj, options|
          Transit::Rails::Renderer.new(obj, options).render
        end
      end
    end
  end
end
