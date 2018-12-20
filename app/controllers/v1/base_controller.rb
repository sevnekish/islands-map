class V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_404(e.model)
  end

  def respond_with_serialized_resource_for(resource = nil, options = {})
    # defaults
    render_args = {
      json: resource,
      serializer: lookup_serializer_for(resource, options),
      adapter: :json,
      status: :ok
    }

    # render with merged options
    render render_args.deep_merge options
  end

  def respond_with_serialized_list_for(collection = [], options = {})
    # defaults
    render_args = {
      json: collection,
      serializer: ActiveModel::Serializer::CollectionSerializer,
      adapter: :json,
      status: :ok
    }

    # render with merged options
    render render_args.deep_merge options
  end

  def lookup_serializer_for(resource, options, lookup_namespace: 'V1')
    options[:namespace] = lookup_namespace unless options[:namespace].present?
    ActiveModel::Serializer.serializer_for(resource, options)
  end

  def render_404(model)
    message = I18n.t('api.errors.record_not_found_error', klass: model)
    render_error(message, 404)
  end

  def render_error(message, status)
    render json: { error: message }, meta: { success: false }, status: status
  end
end