class AddIndexToGovernanceScoreYahoo < ActiveRecord::Migration
  def change
    add_index :governance_score_yahoos, [:symbol, :forDate], :unique => true
  end
end
