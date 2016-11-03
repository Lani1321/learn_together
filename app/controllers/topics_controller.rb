class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end
  
  def show              #=> learntogether.com/topic/1
    @topic = Topic.find(params[:id])
  end

end

