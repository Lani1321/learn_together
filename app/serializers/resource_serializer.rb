class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :title, :link
  has_one :user
end
