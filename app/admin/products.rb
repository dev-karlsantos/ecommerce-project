ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :categories_id, :product_name, :price, :description, :stock_quantity, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:categories_id, :product_name, :price, :description, :stock_quantity, :image]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  # filter :categories_category_name, as: :select, collection: -> { Category.pluck(:category_name, :id) }

  form do |f|
    f.semantic_errors
    f.inputs "Product Details" do
      f.input :category_id, as: :select, collection: Category.all.map { |cat|
                                                       [cat.category_name, cat.id]
                                                     }
      f.input :product_name
      f.input :price
      f.input :description
      f.input :stock_quantity
      f.input :image, as:   :file,
                      # hint: f.object.image.present? ? image_tag(f.object.image.variant(resize_to_limit: [500, 500])) : ''
                      hint: f.object.image.present? ? image_tag(f.object.image, size: "150x150") : ""
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :category do |product|
      product.category.category_name if product.category
    end
    column :product_name
    column :price
    column :description
    column :stock_quantity
    actions
  end

  show do
    attributes_table do
      row :id
      row :category do |product|
        product.category.category_name if product.category
      end
      row :product_name
      row :price
      row :description
      row :stock_quantity
      row :image do |product|
        ActiveStorage::Current.url_options = {
          host: request.base_url
          # add other relevant options if needed
        }
        image_tag product.image.url, size: "150x150" if product.image.present?
      end
    end
    active_admin_comments
  end

  controller do
    def show_title
      product.product_name
    end
  end
end
