class GovernanceScoreYahoo < ActiveRecord::Base
  validates_uniqueness_of :forDate, :scope => [:symbol]
end
