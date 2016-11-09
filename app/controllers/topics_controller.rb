class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end
  
  def show              #=> learntogether.com/topic/1
    @topic = Topic.find(params[:id])
    @resources = @topic.resources.sort{ |a,b| Vote.total_votes(b.id) <=> Vote.total_votes(a.id)}
  end

  def create_resource
    topic = Topic.find(params[:topic_id])
    resource = topic.resources.new(new_resource_params)
    if resource.save
      redirect_to topic
    else
    render 'new_resource'
  end
  end 

  def new_resource
    topic = Topic.find(params[:topic_id])
    @resource = topic.resources.new
  end

  private

    def new_resource_params
      params.require(:resource).permit(:title, :link, :topic_ids => [], :topics_attributes => [:name])
    end


end


