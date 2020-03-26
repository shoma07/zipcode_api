# frozen_string_literal: true

# # ApplicationSerializer
class ApplicationSerializer
  class FieldsError < StandardError; end
  include FastJsonapi::ObjectSerializer

  class << self
    # @return [Hash]
    def field_sets
      ApplicationSerializer.subclasses.each_with_object({}) do |klass, permits|
        permits[klass.record_type] =
          (klass.attributes_to_serialize&.keys || []) +
          (klass.relationships_to_serialize&.keys || [])
      end
    end
  end

  # @see https://github.com/Netflix/fast_jsonapi/blob/fdcaed6f0d72cf793b3117a5081de5fbd7466574/lib/fast_jsonapi/object_serializer.rb#L26
  def initialize(resource, options = {})
    options[:meta] ||= {}
    if resource.is_a?(ActiveRecord::Relation) ||
       resource.is_a?(Kaminari::PaginatableArray)
      options[:meta][:page] = meta_page(resource)
    end
    fields_validate(options[:fields])
    super
  end

  # @see https://github.com/Netflix/fast_jsonapi/blob/fdcaed6f0d72cf793b3117a5081de5fbd7466574/lib/fast_jsonapi/object_serializer.rb#L69
  #
  # @return [String]
  def serialized_json
    json = ActiveSupport::JSON.encode(serializable_hash)
    @pretty ? JSON.pretty_generate(JSON.parse(json)) : json
  end

  private

  # @param resource [Object]
  # @return [Hash]
  def meta_page(resource)
    {
      total: resource.try(:total_count),
      current_page: resource.try(:current_page),
      limit: resource.try(:limit_value),
      offset: resource.try(:offset_value)
    }
  end

  # @raise [ApplicationSerializer::FieldsError]
  def fields_validate(fields = {})
    field_sets = ApplicationSerializer.field_sets
    fields.each do |k, v|
      invalid = v - (field_sets[k] || [])
      next if invalid.size.zero?

      raise FieldsError,
            format('%<invalid>s is not specified as a fields on %<class_name>s',
                   invalid: invalid.join(','), class_name: k)
    end
  end

  # @see https://github.com/Netflix/fast_jsonapi/blob/fdcaed6f0d72cf793b3117a5081de5fbd7466574/lib/fast_jsonapi/object_serializer.rb#L75
  def process_options(options)
    super
    @pretty = options[:pretty]
  end
end
