ActiveAdmin.register Post, as: 'Article' do

  permit_params :title, :by_line, :content, :cover_image

  index do
    selectable_column
    id_column
    column :title
    column 'Author(s)', :by_line
    column :created_at
    column :updated_at
    column 'Published?', :published
    actions
  end

  form partial: 'form'


end
