module ApplicationHelper
  def class_by_type(type)
    case type
    when "notice"
      "bg-success"
    when "alert", "error"
      "bg-danger"
    else
      "bg-white"
    end
  end
end
