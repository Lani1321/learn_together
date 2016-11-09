class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show] #=>This allows a nonuser to see a list of all the resources but only allows users to add resources
 

  def index
     @topic = Topic.find_by(id: params[:topic_id])
  end

  def upvote
    resource = Resource.find(params[:resource][:resource_id])
    if resource.already_voted?(current_user.id)
      resource.no_vote
      redirect_to :back, notice: "You can't vote for the same resource more than once"
      return
    else 
      resource.votes.create(vote_value: 1, user_id: current_user.id)
    end
    redirect_to :back, notice: "You've successfully voted for #{resource.title}"
  end

  def downvote
    resource = Resource.find(params[:resource][:resource_id])
    if resource.already_voted?(current_user.id)
      resource.no_vote
      redirect_to :back, notice: "You can't vote for the same #{resource.title} more than once"
      return
    else 
      resource.votes.create(vote_value: -1, user_id: current_user.id)
    end
    redirect_to :back, notice: "You've successfully voted for this #{resource.title}"
  end

  def create                
    @resources = Resource.all
    @resource = current_user.resources.new(resource_params)
    # Saves the model in the database, returns a boolean if it's saved or not
    # if @resource.save fails in this situation, we need to show the form back to the user. 
    if @resource.save
    # Redirect to show action
      redirect_to '/', alert: "You have successfully created '#{@resource.title}'"
    else 
      # We use render instead of redirect_to when save returns false. 
      # The render method is used so that the @resource object is passed back to the new template when it is rendered.
      # This rendering is done within the same request as the form submission, whereas the redirect_to will tell the browser to issue another request.
      render 'new'
    end
  end

  def new
    @user = current_user
    @resource = Resource.new
    @topics = @resource.topics.build
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    # if @resource.update(resource_params)
    if !current_user
      redirect_to new_user_session_path, alert: "You must be the author in order to edit a resource."
    elsif current_user != @resource.user
      redirect_to :back, alert: "You must be the author in order to edit a resource."
    else
      @resource.update(resource_params)
      redirect_to '/', alert: "You have successfully edited your resource"
    end
  end
      
  # Don't need to add a view for this action since we're redirecting to the index action
  def destroy
    if !current_user
      redirect_to new_user_session_path, alert: "You must be the author in order to delete a resource."
    elsif current_user != @resource.user
      redirect_to :back, alert: "You must be the author in order to delete a resource."
    else
      @resource.destroy
      redirect_to :back, alert: "Your resource has successfully been deleted"
    end
  end

  private

    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      params.require(:resource).permit(:title, :link, :topic_ids => [], :topics_attributes => [:name])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
