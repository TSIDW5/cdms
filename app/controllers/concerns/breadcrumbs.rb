module Breadcrumbs
  extend ActiveSupport::Concern

  included do
    before_action :breadcrumbs
  end

  module ClassMethods
    attr_reader :args

    private

    def breadcrumbs_options(*args)
      @args = args
    end
  end

  # rubocop:disable Metrics/AbcSize
  def breadcrumbs
    add_breadcrumb model.model_name.human(count: 2), send("#{namespace}#{controller_name}_path")

    case action_name.to_sym
    when :new, :create
      add_breadcrumb I18n.t("views.breadcrumbs.new.#{gender}"), send("new_#{namespace}#{model_name}_path")
    when :show
      show_breadcrumbs
    when :edit, :update
      show_breadcrumbs
      add_breadcrumb I18n.t('views.breadcrumbs.edit'), send("edit_#{namespace}#{model_name}_path")
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def show_breadcrumbs
    add_breadcrumb I18n.t('views.breadcrumbs.show',
                          model: instance.model_name.human,
                          id: instance.id),
                   send("#{namespace}#{model_name}_path", instance)
  end

  def model
    controller_name.classify.constantize
  end

  def model_name
    model.to_s.underscore
  end

  def instance
    @instance ||= instance_variable_get("@#{model_name}")
  end

  def gender
    return :f if self.class.args&.include?(:female)

    :m
  end

  def namespace
    npe = self.class.module_parent.to_s.downcase
    return '' if npe.eql?('object')

    "#{npe}_"
  end
end
