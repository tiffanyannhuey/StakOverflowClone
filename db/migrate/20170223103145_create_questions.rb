class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string   :title, {null: false}
      t.text     :description, {null: false}
      t.integer  :author_id, {null: false}
      t.integer  :best_answer

      t.timestamps(null:false)
    end
  end
end
