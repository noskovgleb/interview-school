# frozen_string_literal: true

Rails.logger = Logger.new(STDOUT)
Rake::Task['db:fixtures:load'].invoke

require 'faker'
require 'active_record'

def reset_database
  ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = OFF')
  ActiveRecord::Base.connection.tables.each do |table|
    next if table == 'schema_migrations'

    ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
    ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='#{table}'")
  end

  ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = ON')
end

reset_database

10.times do
  Subject.create(name: Faker::Educator.subject)
end

10.times do
  Teacher.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

Teacher.all.each do |teacher|
  subjects = Subject.all.sample(3)
  subjects.each do |subject|
    TeacherSubject.create(
      teacher_id: teacher.id,
      subject_id: subject.id,
      level: rand(1..5)
    )
  end
end

10.times do
  Student.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

10.times do
  Classroom.create(
    name: rand(100..500)
  )
end

Student.all.each do |_student|
  teacher_subjects = TeacherSubject.all.sample(3)
  start_time = Faker::Time.between(from: DateTime.now, to: DateTime.now + rand(1..10).days)
  teacher_subjects.each do |subject|
    Section.create(
      teacher_subject_id: subject.id,
      classroom_id: Classroom.order('RANDOM()').take.id,
      start_time: start_time,
      end_time: start_time + 50 * 60,
      days: Date::DAYNAMES.sample(3).join(',')
    )
  end
end

Student.all.each do |student|
  student.sections << Section.all.sample(1)
end
