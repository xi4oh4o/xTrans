module ApplicationHelper

  def valid_field(resource, field)
    resource.errors[field].empty? ? "" : "error"
  end

  def flash_class_level(level)
    case level
    when "success" then "ui success message"
    when "error" then "ui error message"
    when "notice" then "ui blue message"
    when "alert" then "ui yellow message"
    end
  end
end
