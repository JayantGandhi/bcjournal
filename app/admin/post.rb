ActiveAdmin.register Post do

  permit_params :title, :by_line, :content

  form do |f|
    f.inputs "Post" do
      f.input :title
      f.input :by_line
      f.input :content, as: :ckeditor
    end
    f.actions
  end


end
