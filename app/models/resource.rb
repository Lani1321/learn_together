class Resource < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :resource_topics
  has_many :topics, :through => :resource_topics
  accepts_nested_attributes_for :topics, reject_if: lambda {|attributes| attributes['name'].blank?}
  validates :title, presence: true
  validates :link, :format => URI::regexp(%w(http https))
  has_many :votes

  def vote_score
    score = 0
    votes.each do |vote|
      score += vote.vote_value
    end
    score
  end
end


  # def self.by_votes
  #   select('resources.*, coalesce(value, 0) as votes')
  #   joins('left join resource_votes on resource_id=resources.id')
  #   order('votes desc')
  # end

  # def votes 
  #   read_attributes(:votes) || resource_votes.sum(:value)
  # end

