# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :teacher_subject
  belongs_to :classroom
  has_many :student_sections
  has_many :students, through: :student_sections

  validate :no_time_conflict

  private

  def no_time_conflict
    sections = Section.where(classroom: classroom)
    sections.each do |section|
      if days_overlap?(section.days, days) && times_overlap?(section.start_time, section.end_time, start_time, end_time)
        errors.add(:base, 'Time conflict detected in the same classroom')
      end
    end
  end

  def days_overlap?(days1, days2)
    days1.split(',').any? { |day| days2.split(',').include?(day) }
  end

  def times_overlap?(start1, end1, start2, end2)
    (start1 < end2 && end1 > start2)
  end
end
