require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    word = params[:word]
    letters = params[:letters].split
    @message = nil
    word.split("").each do |char|
      if !letters.index(char.upcase)
        @message = "Sorry but #{word.upcase} can't be built out of #{letters}"
      else
        letters.delete_at(letters.index(char.upcase))
      end
    end
    if !@message
      if check_dict(word)
        @message = "Congratulations! #{word.upcase} is a valid English word!"
      else
        @message = "Sorry but #{word.upcase} does not seem to be a valid English word"
      end
    end
  end

  private

  def check_dict(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    response = JSON.parse(response)
    response["found"]
  end
end
