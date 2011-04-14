class Item
  extend ActiveModel::Naming
  extend ActiveModel::Callbacks
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  include ActiveModel::Conversion
  include ActiveModel::Validations

  define_attribute_methods [:title, :path, :file, :upload_only]
  define_model_callbacks :save, :only => :before
  attr_accessor :title, :path, :file, :upload_only

  validates_presence_of(:title, :unless => Proc.new { |item| item.upload_only })
  validates_presence_of(:path, :if => Proc.new { |item| item.file.nil? })

  before_save :make_file_path

  def initialize(attributes = {})
    attributes.stringify_keys!
    @title = attributes["title"]
    @path = attributes["path"]
    @file = attributes["file"]
    @upload_only = attributes["upload_only"]
  end

  def persisted?
    false
  end

  def make_file_path
    if self.file
      dir = Rails.root.join('tmp')
      dir.mkpath unless dir.exist?
      dest = dir.join(self.file.original_filename)
      FileUtils.cp(self.file.path, dest)
      self.path = dest
    end
  end

  def save
    run_callbacks(:save) do
      self.valid?
    end
  end
end
