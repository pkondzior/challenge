class Item
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  include ActiveModel::Conversion

  define_attribute_methods [:title, :path]
  attr_accessor :title, :path

  def initialize(attributes = {})
    @attributes = attributes
  end

  def persisted?
    false
  end
end
