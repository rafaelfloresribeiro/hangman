require 'csv'
require 'pry-byebug'
# Dictionary to gather all the words
class Dictionary
  def words_generator
    dictionary = File.open('../files/google-10000-english-no-swears.txt')
    word_map = dictionary.readlines.map { |word| word.chomp if word.chomp.length >= 4 && word.chomp.length <= 11 }
    word_map.compact.sample
  end
end

# Presentation text to start the game
module Presentation
  puts INTRO = <<~TEXT.freeze
    Welcome to the classic game of hangman
    this game will take a word with between 5 and 12
    characters, and you'll have to guess!
    you have 5 lives, that will be presented to you
    with your past guesses and correct guesses
    Example:
    \n
    e _ _ _ e - 3 guesses left - past guesses: I, U
    \n
    the word was E A G L E
    \n
    you must type character by character
  TEXT
end

# Defining how the game logic plays out
class PlayGame
  def self.intro
    Presentation::INTRO
  end
end

# class to handle all input comparisons
class InputComparison
  def ask_input
    puts 'type a character'
  end

  def player_input
    loop do
      ask_input
      answer = gets.chomp
      valid_input?(answer)
      break
    rescue InvalidInputError
      puts 'Invalid input, try again.'
    end
  end

  def valid_input?(input)
    raise InvalidInputError unless input.match?(/[a-zA-Z]/)
  end
end

class InvalidInputError < StandardError
end

PlayGame.intro
a = InputComparison.new
a.player_input
