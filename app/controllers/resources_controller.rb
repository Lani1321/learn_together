class ResourcesController < ApplicationController

  def index
    @resources = Resource.all
  end

  def show
    # Find the resource we're interested in, passing in params[:id] to get the :id parameter from the request
    @resource = Resource.find(params[:id])
  end

  def new
    @resource = Resource.new
  end

  def edit
    @resource = Resource.find(params[:id])
  end


  def create                #=> params[:attribute] contains the attributes I'm interested in
    # @resource = Resource.new(params[:resource])
    # @resource = Resource.new(params.require(:resource).permit(:title, :link))
    @resource = Resource.new(resource_params)
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

  def update
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      redirect_to @resource
    else
      render 'edit'
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :link)
  end

end
