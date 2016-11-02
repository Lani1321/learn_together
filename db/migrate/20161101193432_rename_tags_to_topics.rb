class RenameTagsToTopics < ActiveRecord::Migration[5.0]
  def change
    rename_table :tags, :topics
    rename_table :resource_tags, :resource_topics
  end
end
