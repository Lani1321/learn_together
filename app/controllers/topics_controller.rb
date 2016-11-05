class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end
  
  def show              #=> learntogether.com/topic/1
    @topic = Topic.find(params[:id])
    @resources = @topic.resources.joins(:votes).select('resources.*, COUNT(votes.id) AS vote_value').group('votes.resources_id').order('vote_value DESC')
    # @resource = Resource.joins(:votes).select('resources.*, COUNT(votes.id) AS vote_value').group('votes.resources_id').order('vote_value DESC')

  
  end

end