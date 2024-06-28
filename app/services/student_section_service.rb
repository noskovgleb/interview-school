# frozen_string_literal: true

class StudentSectionService
  def call(student)
    student_sections = Hash.new { |h, k| h[k] = [] }
    Date::DAYNAMES.each do |day|
      student_sections[day] << student.sections.where('days like ?', "%#{day}%")
    end

    student_sections
  end
end
