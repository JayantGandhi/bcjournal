ActiveAdmin.register Post do

  permit_params :title, :by_line, :content, :cover_image

  menu priority: 1, label: 'Manage Posts'

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

  action_item only: :show do
    if post.published
      link_to('View on site', post_path(post))
      link_to('Unpublish', post_unpublish_path(post))
    else
      link_to('Preview', post_path(post))
      link_to('Publish', post_publish_path(post))
    end
  end

  form partial: 'form'


end
