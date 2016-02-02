module ApplicationHelper

  def valid_field(resource, field)
    resource.errors[field].empty? ? "" : "error"
  end
end
