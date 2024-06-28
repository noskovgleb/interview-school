class Student < ApplicationRecord
  has_many :student_sections, dependent: :destroy
  has_many :sections, through: :student_sections, dependent: :destroy

  def first_and_last_name
    "#{first_name} #{last_name}"
  end
end
