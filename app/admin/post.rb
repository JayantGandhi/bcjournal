ActiveAdmin.register Post do

  permit_params :title, :by_line, :content

  form do |f|
    f.inputs "Post", multipart: true do
      f.input :title
      f.input :cover_image, as: :file, hint: f.template.image_tag(f.object.cover_image.url(:thumb))
      f.input :by_line
      f.input :content, as: :ckeditor
    end
    f.actions
  end


end
