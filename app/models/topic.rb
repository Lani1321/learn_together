class Topic < ApplicationRecord
  has_many :resource_topics
  has_many :resources, :through => :resource_topics

def num_of_resources
  self.resources.count
end

end
