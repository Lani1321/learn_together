class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show] #=>This allows a nonuser to see a list of all the resources but only allows users to add resources


  def index
    @resources = Resource.all 

  end

  def show
    # Find the resource we're interested in, passing in params[:id] to get the :id parameter from the request
    @resource = Resource.find(params[:id])
  end

  def vote
    resource = Resource.find(params[:resource][:resource_id])
    if params[:commit] == "Upvote"
      resource.votes.create(vote_value: 1)
    else
      resource.votes.create(vote_value: -1)
    end
    redirect_to :back
  end

  def create                #=> params[:attribute] contains the attributes I'm interested in
    @resource = current_user.resources.new(resource_params)
    # Saves the model in the database, returns a boolean if it's saved or not
    # if @resource.save fails in this situation, we need to show the form back to the user. 
    if @resource.save
    # Redirect to show action
      redirect_to @resource
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
      redirect_to resource_path(@resource)
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
      redirect_to resources_path
    end
  end

  private

    def set_resource
      @resource = Resource.find(params[:id])
    end

    # added user_id to see if it works
    def resource_params
      params.require(:resource).permit(:title, :link, :topic_ids => [], :topics_attributes => [:name])
    end

end
