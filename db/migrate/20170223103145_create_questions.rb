class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text     :description, {null: false}
      t.integer  :author_id, {null: false}

      t.timestamps(null:false)
    end
  end
end
