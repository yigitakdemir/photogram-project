class PhotosController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })
  def index
    private_users = User.where(private: false)
    id_of_private_users = []
    private_users.each do |user|
      id_of_private_users = id_of_private_users + [user.id]
    end
    @list_of_photos = Photo.all.where(owner_id: id_of_private_users).order(created_at: :desc)
    render(template: "photos_html/index")
  end

  def show
    my_photo_id = params.fetch("photo_id")
    @the_photo = Photo.where(id: my_photo_id).first

    if @the_photo == nil
      redirect_to("/404")
    else
      render(template: "photos_html/show")
    end
  end

  def delete
    my_photo_id = params.fetch("photo_id")
    the_photo = Photo.where(id: my_photo_id).first
    the_photo.destroy
    # render(template: "photos_html/delete")
    redirect_to("/photos")
  end

  def create
    image = params.fetch("input_image")
    caption = params.fetch("input_caption")
    owner_id = params.fetch("input_owner_id")
    new_photo = Photo.new
    new_photo.image = image
    new_photo.caption = caption
    new_photo.owner_id = owner_id
    new_photo.likes_count = 0
    new_photo.comments_count = 0
    new_photo.save
    # render(template: "photos_html/delete")
    redirect_to("/photos/", { :notice => "Photo created successfully." })
  end

  def update
    my_photo_id = params.fetch("photo_id")
    caption = params.fetch("input_caption")
    image = params.fetch("input_image")
    the_photo = Photo.where(id: my_photo_id).first
    the_photo.caption = caption
    the_photo.image = image
    the_photo.save
    redirect_to("/photos/" + my_photo_id)
  end

  def comment
    input_photo_id = params.fetch("input_photo_id")
    input_comment = params.fetch("input_comment")
    new_comment = Comment.new
    new_comment.body = input_comment
    new_comment.author_id = current_user.id
    new_comment.photo_id = input_photo_id
    new_comment.save

    matching_photo = Photo.where(id: input_photo_id).first
    matching_photo.comments_count = matching_photo.comments_count + 1
    matching_photo.save

    redirect_to("/photos/" + input_photo_id)
  end

  def like
    input_photo_id = params.fetch("input_photo_id")
    new_like = Like.new
    new_like.photo_id = input_photo_id
    new_like.fan_id = current_user.id
    new_like.save

    matching_photo = Photo.where(id: input_photo_id).first
    matching_photo.likes_count += 1
    matching_photo.save

    redirect_to("/photos/" + input_photo_id, { :notice => "Like created successfully." })
  end

  def unlike
    like_id = params.fetch("like_id")
    matching_like = Like.where(id: like_id.to_i).first
    photo_id = matching_like.photo_id
    matching_like.destroy

    redirect_to("/photos/" + photo_id.to_s, { :alert => "Like deleted successfully." })
  end

end
