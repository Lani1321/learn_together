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


  def no_vote 
    score = 0
    score
  end


  def already_voted?(user_id) 
                    #=> key that represents the column on the votes table
                              #=>argument we pass through 
     # if something is there, then it will return an array of vote instances, if not it will be empty
    if self.votes.where(user_id: user_id).empty?
      false
    else
      true
    end
  end

end

