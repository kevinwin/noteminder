module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    object_id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("deck_fields", f: builder)
  end

    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def resource_name
    :user
  end

  def resource
    @resource = User.new
  end

  def devise_mapping
    @devise_mapping = Devise.mappings[:user]
  end
  
def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
end

  
end
