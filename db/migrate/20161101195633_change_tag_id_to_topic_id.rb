class ChangeTagIdToTopicId < ActiveRecord::Migration[5.0]
  def change
    rename_column :resource_topics, :tag_id, :topic_id
  end
end
