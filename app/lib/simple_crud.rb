# SimpleCrud aims to provide a unified behaviour to the common CRUD controller
#
# You should include this Module in the controller you want to simplify and
# using the `model` method, define the name of the variable you want to define
# and options.
#
# The module offers several hooks to be implemented on the controller, to aid
# in the process of customizing the behaviour of the controller.
#
# Example:
#   class ActivationMethodsController < ManagementConsoleController
#     include SimpleCrud::Base
#     model :activation_method, includes: [placements: [:program]]
#   end

module SimpleCrud

  # Defines the common behaviour
  module BaseMacros
    def model(name, options={})
      model_constructor = name.to_s.camelize.constantize
      model_name = options[:as].present? ? options[:as].to_s : name.to_s
      includes = options[:includes].present? ? options[:includes] : nil
      order = options[:order].present? ? options[:order].to_s : nil
      scope = options[:scope]

      define_method(:model) { model_constructor }
      define_method(:model_name) { model_name }
      define_method(:model_with_includes) { model.includes(includes).order(order) }
    end
  end

  # Base functionality for a controller
  module Base

    def self.included(base)
      base.extend BaseMacros
    end

    ## Controller actions
    def index
      @_mode = :index
      @_collection = collection.page(params[:page])
      @actions = get_collection_actions
      prepare_env
    rescue => e
      error(e)
    end

    def show
      @_mode = :show
      @_instance = instance
      @actions = get_model_actions
      prepare_env
      hook_after_show
    rescue ActiveRecord::RecordNotFound
      redirect_to collection_path, alert: "#{model_name.titleize} not found"
    end

    def new
      @_mode = :new
      @_instance = model.new
      prepare_env
      hook_after_new
    rescue => e
      error(e)
    end

    def create
      @_mode = :create
      @_instance = model.new
      create_update
    rescue ActiveRecord::RecordNotFound => e
      redirect_to collection_path, alert: "#{model_name.titleize} not found"
    rescue => e
      error(e)
    end

    def edit
      @_mode = :edit
      @_instance = instance
      @actions = get_collection_actions
      prepare_env
    rescue ActiveRecord::RecordNotFound => e
      redirect_to collection_path, alert: "#{model_name.titleize} not found"
    rescue => e
      error(e)
    end

    def update
      @_mode = :update
      @_instance = instance
      @actions = get_collection_actions
      create_update
    rescue ActiveRecord::RecordNotFound => e
      redirect_to collection_path, alert: "#{model_name.titleize} not found"
    rescue => e
      error(e)
    end

    def destroy
      @_mode = :delete
      @_instance = instance
      if @_instance.destroy
        hook_after_destroy
        head :ok and return if request.xhr?
        redirect_to collection_path, notice: "#{model_name.titleize} successfully #{@_mode}d"
      else
        head 400 and return if request.xhr?
        render :edit, alert: 'There was an error'
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to collection_path, alert: "#{model_name.titleize} not found"
    rescue => e
      error(e)
    end


    private

    # Basic creation/updation core
    def create_update
      hook_before_assign
      hook_before_assign_on_mode
      @_instance.assign_attributes(self.send("#{model_name}_params"))
      hook_after_assign
      hook_after_assign_on_mode
      hook_before_save
      hook_before_save_on_mode
      if @_instance.errors.empty? && @_instance.save
        hook_after_save
        hook_after_save_on_mode
        return if send("hook_success_response_#{@_mode}")
        head :ok and return if request.xhr?
        redirect_to @_instance, notice: 'Successfully saved'
      else
        return if send("hook_error_response_#{@_mode}")
        head 400 and return if request.xhr?
        prepare_env
        if create?
          render :new
        else
          render :edit, alert: 'There was an error'
        end
      end
    end

    ## Hooks
    def hook_before_assign_on_mode
      send "hook_before_assign_on_#{@_mode}"
    end

    def hook_after_assign_on_mode
      send "hook_after_assign_on_#{@_mode}"
    end

    def hook_before_save_on_mode
      send "hook_before_save_on_#{@_mode}"
    end

    def hook_after_save_on_mode
      send "hook_after_save_on_#{@_mode}"
    end

    ## Actions helpers
    def get_actions(actions)
      ActionPresenter.new(actions)
    end

    def get_model_actions
      if @_instance.respond_to? :actions
        get_actions instance.actions
      else
        []
      end
    end

    def get_collection_actions
      if model.respond_to? :all_actions
        get_actions model.all_actions
      else
        []
      end
    end

    ## Variable helpers
    def prepare_env
      if defined? @_instance
        instance_variable_set("@#{model_name}", @_instance)
      elsif defined? @_collection
        instance_variable_set("@#{model_name.pluralize}", @_collection)
      end
    end

    ## Model helpers
    def collection
      model_with_includes
    end

    def instance
      collection.find(params[:id])
    end

    ## Mode helpers
    def update?
      @_mode == :update
    end

    def create?
      @_mode == :create
    end

    ## Path helpers
    def collection_path
      controller = if scope.present?
                     "#{scope}_#{model_name.pluralize}"
                   else
                     model_name.pluralize
                   end
      { controller: controller, action: 'index' }
    end

    ## Empty hooks
    def empty;end
    [
      :hook_before_assign,
      :hook_after_assign,
      :hook_before_save,
      :hook_after_save,
      :hook_before_assign_on_create,
      :hook_after_assign_on_create,
      :hook_before_save_on_create,
      :hook_after_save_on_create,
      :hook_before_assign_on_update,
      :hook_after_assign_on_update,
      :hook_before_save_on_update,
      :hook_after_save_on_update,
      :hook_after_new,
      :hook_after_show,
      :hook_success_response_create,
      :hook_error_response_create,
      :hook_success_response_update,
      :hook_error_response_update,
      :hook_after_destroy
    ].each { |method_name| alias_method method_name, :empty }

    ## Error management
    def error(exception)
      raise exception
      redirect_to root_path, alert: "There was an error: #{exception.message}"
    end
  end

  module Helpers # HasManyHelpers
    def hook_success_response_create
      if request.xhr?
        respond_to do |format|
          format.json
        end
        return true
      end
    end
  end

end
