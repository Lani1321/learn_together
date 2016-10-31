class Resource < ApplicationRecord
  validates :title, presence: true
  validates :link, :format => URI::regexp(%w(http https))
end
