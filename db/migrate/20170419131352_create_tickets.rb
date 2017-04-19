class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.string :comment # 中間テーブルに関連entity以外を乗せるのは有りなんですね。

      t.timestamps
    end
    # TODO: 逆方向のindexも必要!????
    add_index :tickets, [:user_id, :event_id], unique: true
    add_index :tickets, [:event_id, :user_id], unique: true
  end
end
