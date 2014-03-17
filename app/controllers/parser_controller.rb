require 'open-uri'
require 'nokogiri'

class ParserController < ApplicationController
  def self._getPage(url)
    source = open(url, &:read)
    return source
  end
  
  def self._getSP500Symbols()
    url = 'http://en.wikipedia.org/wiki/List_of_S&P_500_companies'
    page = self._getPage(url)
    html_doc = Nokogiri::HTML(page)
    
    symbols = []
    
    table = html_doc.xpath("//table[1]") #get first table
    table.search('tr').each do |tr|
      #puts '\n'
      count = 0
      tr.search('td').each do |td|
        if count==0
          if td.text.length>0
            symbols << td.text.strip
          end
        end
        count += 1
      end
    end
    
    return symbols
    
    
  end
  
  def self.getGovernanceScoreYahoo(symbol)
    #look up symbol
    page = self._getPage('http://finance.yahoo.com/q/pr?s=%s' % (symbol))
    
    #scrape page for governance scores
    #all of them: quickscore, audit, board, shareholder rights, compensation
    match = /.*Corporate Governance.*?ISS.*as of (?<forDate>.*?)is\W(?<quickscore>\d+).*Audit:\W(?<audit>\d+).*Board:\W(?<board>\d+).*Rights:\W(?<shareholderRights>\d+).*Compensation:\W(?<compensation>\d+)/.match(page)
    
    if match.blank?
      return nil
    end
    
    forDate = DateTime.parse(match[:forDate]).to_date
    
    return {:symbol => symbol.downcase, :forDate => forDate, :quickscore => match[:quickscore].to_i, :audit => match[:audit].to_i, :board => match[:board].to_i, :shareholderRights => match[:shareholderRights].to_i, :compensation => match[:compensation]}
      
  end
  
  def self.scrapeForGovernanceScores()
    symbols = self._getSP500Symbols()
    symbols.each do |symbol|
      
      object = self.getGovernanceScoreYahoo(symbol)
      next if object.blank?
      
      GovernanceScoreYahoo.create({:symbol => object[:symbol], :forDate => object[:forDate], :quickscore => object[:quickscore], :audit => object[:audit], :board => object[:board], :shareholderRights => object[:shareholderRights], :compensation => object[:compensation]})
    end
  end

  def self._percentile(values, percentile)
    values_sorted = values.sort
    k = (percentile*(values_sorted.length-1)+1).floor - 1
    f = (percentile*(values_sorted.length-1)+1).modulo(1)

    return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
  
  end
  
  def self._calcCustomQuickScore(scoreObj)
    return (scoreObj[:audit]+scoreObj[:board]+scoreObj[:shareholderRights]+scoreObj[:compensation]).to_f / 4.0
  end
  
  def self.getWorstGovernanceScores(percentile = 0.01)
    #get most recent for date
    #using a hacky method: get last inserted item's for date
    lastItem = GovernanceScoreYahoo.last
    forDate = lastItem[:forDate]
    #get all scores with that for date
    allScores = GovernanceScoreYahoo.where(forDate: forDate)
    
    #my own custom quick score: just the average of compensation, shareholder rights, etc.
    allQuickScores = []
    allScores.each do |scoreObj|
      allQuickScores << _calcCustomQuickScore(scoreObj)
    end

    #puts allQuickScores
    
    quantile = self._percentile(allQuickScores,1-percentile)
    #puts quantile
    
    filteredObjs = []
    allScores.each do |scoreObj|
      if self._calcCustomQuickScore(scoreObj)>quantile
        filteredObjs << scoreObj
      end
    end
    
    return filteredObjs
    
  end
end
