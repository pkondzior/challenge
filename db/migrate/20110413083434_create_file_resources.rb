class CreateFileResources < ActiveRecord::Migration
  def self.up
    create_table :file_resources do |t|
      t.string :title
      t.text :path

      t.timestamps
    end
  end

  def self.down
    drop_table :file_resources
  end
end
