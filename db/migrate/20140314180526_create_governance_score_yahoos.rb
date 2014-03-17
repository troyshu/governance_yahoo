class CreateGovernanceScoreYahoos < ActiveRecord::Migration
  def change
    create_table :governance_score_yahoos do |t|
      t.string :symbol
      t.date :forDate
      t.integer :quickscore
      t.integer :audit
      t.integer :board
      t.integer :shareholderRights
      t.integer :compensation

      t.timestamps
    end
  end
end
