class Resource < ApplicationRecord
  belongs_to :user
  has_many :resource_topics
  has_many :topics, :through => :resource_topics
  accepts_nested_attributes_for :topics, reject_if: lambda {|attributes| attributes['name'].blank?}
  validates :title, presence: true
  validates :link, :format => URI::regexp(%w(http https))
end
