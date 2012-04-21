module RailsTemporaryData
  class Engine < ::Rails::Engine

    config.after_initialize do
      ApplicationController.send(:include, RailsTemporaryData::ControllerHelpers)
    end

  end
end