class Resource < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :resource_topics
  has_many :topics, :through => :resource_topics
  accepts_nested_attributes_for :topics, reject_if: lambda {|attributes| attributes['name'].blank?}
  validates :title, presence: true
  validates :link, :format => URI::regexp(%w(http https))
  has_many :votes
  validate :must_have_one_topic

  def must_have_one_topic
     errors.add(:topics, ':You must select at least one topic') unless self.topics.detect { |i| i != "0" } 
 end

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
     # if something is there, then it will return an array of vote instances, if not it will be empty
    if self.votes.where(user_id: user_id).empty?
      false
    else
      true
    end
  end

  def topics_attributes=(topics_attributes)
    topics_attributes.values.each do |topic_attribute|
      if topic_attribute[:name].present?
        topic = Topic.find_or_create_by(name: topic_attribute[:name])
        if !self.topics.include?(topic)
          self.resource_topics.build(:topic => topic)
      # self.categories << category
        end
      end
    end
  end


end

