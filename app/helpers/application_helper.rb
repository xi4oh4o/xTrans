module ApplicationHelper

  def valid_field(resource, field)
    resource.errors[field].empty? ? "" : "error"
  end

  def valid_login_field(resource, field)
    resource[field].empty? ? "" : "error"
  end

  def flash_class_level(level)
    case level
    when "success" then "ui success message"
    when "error" then "ui error message"
    when "notice" then "ui success message"
    when "alert" then "ui error message"
    end
  end
end
