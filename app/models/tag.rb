class Tag < ApplicationRecord
  has_many :resource_tags
  has_many :tags, :through => :resource_tags
end
