ForestLiana::ResourcesController.class_eval do
  alias_method :default_update, :update

  def update
    control_picture
    default_update
  end

  private

  def control_picture
    file = params['resource']['data']['attributes']['image'].to_s
    unless "base64".in? file
      params['resource']['data']['attributes'].delete :image
      puts "Removed image url from params"
    end
  end

  def remove_old_picture
    if @resource.respond_to?(:image) && params[:image].present?
      old_picture = @resource.image
      deleted_picture = old_picture.delete
      deleted_picture.try(:remove!) # delete picture from S3
      puts 'deleted previous image'
    else
      puts 'no previous image to delete'
    end
  end

end