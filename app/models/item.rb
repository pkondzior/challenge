class Item
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  include ActiveModel::Conversion
  include ActiveModel::Validations

  define_attribute_methods [:title, :path]
  attr_accessor :title, :path

  validates_presence_of(:title, :path)

  def initialize(attributes = {})
    attributes.stringify_keys!
    @title = attributes["title"]
    @path = attributes["path"]
  end

  def persisted?
    false
  end
end
