require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a
    @grid = []
    10.times { @grid << @letters.sample }
  end

  def score
    @guess = params[:guess]
    @grid = params[:grid].split(' ')
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    check_serialized = open(url).read
    check = JSON.parse(check_serialized)
    guess_grid = @guess.upcase.split("")
    @result_string = ''

    if guess_grid.all? { |letter| @grid.delete_at(@grid.index(letter)) if @grid.include?(letter) }
      if check["found"]
        @result_string = "Congratulations! #{@guess.upcase} is a valid word!"
      else
        @result_string = "Sorry, but #{@guess.upcase} is not a valid english word :'("
      end
    else
      @result_string = "Sorry, but #{@guess.upcase} cannot be built from #{@grid.join(' ')}"
    end
  end
end
