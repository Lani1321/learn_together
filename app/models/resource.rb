class Resource < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :link, :format => URI::regexp(%w(http https))
end
