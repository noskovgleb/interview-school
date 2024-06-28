class StudentSection < ApplicationRecord
  belongs_to :student
  belongs_to :section

  validate :no_schedule_conflict

  def no_schedule_conflict
    student.sections.each do |existing_section|
      if days_overlap?(existing_section.days, section.days) && times_overlap?(existing_section.start_time, existing_section.end_time, section.start_time, section.end_time)
        errors.add(:base, "Schedule conflict detected")
      end
    end
  end

  private

  def days_overlap?(days1, days2)
    days1.split(',').any? { |day| days2.split(',').include?(day) }
  end

  def times_overlap?(start1, end1, start2, end2)
    (start1 < end2 && end1 > start2)
  end
end
