ActiveAdmin.register Post do

  permit_params :title, :by_line, :content, :cover_image

  def edit
    @post = Post.find_by_id(params[:id])
    puts @post.title
  end

  form partial: 'form'


end
