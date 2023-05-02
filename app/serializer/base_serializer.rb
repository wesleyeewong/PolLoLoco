# frozen_string_literal: true

class BaseSerializer
  def initialize(object)
    instance_variable_set(object_ivar_name, object)
    define_singleton_method(object_name) { instance_variable_get(object_ivar_name) }
  end

  private

  def object_name
    @object_name ||= self.class.name.tableize.split("_").first
  end

  def object_ivar_name
    :"@#{object_name}"
  end
end
