class CourseDecorator < ApplicationDecorator
  delegate_all

  def show_teacher_name
    object.teacher.present? ? object.teacher.person_name : I18n.t("words.to_allocate")
  end
end
