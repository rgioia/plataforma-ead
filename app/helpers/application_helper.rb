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

  def boolean_tag(boolean)
    boolean ? I18n.t("words.boolean_yes") : I18n.t("words.boolean_no")
  end
end