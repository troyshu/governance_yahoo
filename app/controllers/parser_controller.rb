require 'open-uri'

class ParserController < ApplicationController
  def self._getPage(url)
    source = open(url, &:read)
    return source
  end
  
  def self.getGovernanceScoreYahoo(symbol)
    #look up symbol
    page = self._getPage('http://finance.yahoo.com/q/pr?s=%s' % (symbol))
    
    #scrape page for governance scores
    #all of them: quickscore, audit, board, shareholder rights, compensation
    match = /.*Corporate Governance.*?ISS.*as of (?<forDate>.*?)is\W(?<quickscore>\d+).*Audit:\W(?<audit>\d+).*Board:\W(?<board>\d+).*Rights:\W(?<shareholderRights>\d+).*Compensation:\W(?<compensation>\d+)/.match(page)
    forDate = DateTime.parse(match[:forDate]).to_date
    
    
    
      
  end
end
