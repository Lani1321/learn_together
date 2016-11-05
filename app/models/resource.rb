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

  def add_vote
    score = 0
    votes.each do |vote|
      score + vote.vote_value
    end
    score
  end

  def subtract_vote
    score = 0
    votes.each do |vote|
      score - vote.vote_value
    end
    score
  end


  def order_by_votes
    self.votes.count
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

  def most_votes
    @resource = Resource.joins(:votes).select('resources.*, COUNT(votes.id) AS vote_value').group('votes.resources_id').order('vote_value DESC')

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

