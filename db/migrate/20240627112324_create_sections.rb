class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :teacher_subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :days

      t.timestamps
    end
  end
end
