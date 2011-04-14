class Item
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  include ActiveModel::Conversion
  include ActiveModel::Validations

  define_attribute_methods [:title, :path, :file]
  attr_accessor :title, :path, :file

  validates_presence_of(:title)
  validates_presence_of(:path, :if => Proc.new { |item| item.file.nil?  })

  def initialize(attributes = {})
    attributes.stringify_keys!
    @title = attributes["title"]
    @path = attributes["path"]
    @file = attributes["file"]
  end

  def persisted?
    false
  end

  def save
    if self.file && self.path.blank?
      dir = Rails.root.join('tmp')
      dir.mkpath unless dir.exist?
      source = self.file.path
      dest = dir.join(self.file.original_filename)
      FileUtils.cp(source, dest)
      self.path = dest
    end
  end
end
