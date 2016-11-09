class Vote < ApplicationRecord
  
  belongs_to :resource
  belongs_to :user

  def self.total_votes(resource_id)
    votes = Vote.where(resource_id: resource_id).sum("vote_value")
  end
  
end

