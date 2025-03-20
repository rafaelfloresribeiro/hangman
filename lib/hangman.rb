require 'csv'
require 'pry-byebug'
# Dictionary to gather all the words
class Dictionary
end

# Presentation text to start the game
module Presentation
  INTRO = <<~TEXT.freeze
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

# class to handle all comparisons
class Comparison
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def words_generator
    dictionary = File.open('../files/google-10000-english-no-swears.txt')
    word_map = dictionary.readlines.map { |word| word.chomp if word.chomp.length >= 4 && word.chomp.length <= 11 }
    Comparison.new(word_map.compact.sample)
  end

  def self.hide_string(string)
    string.value.chars.map { '_ ' }.join
  end

  def ask_input
    'type a character'
  end

  def player_input
    loop do
      puts ask_input
      answer = gets.chomp
      valid_input?(answer)
      break Comparison.new(answer)
    rescue InvalidInputError
      puts 'Invalid input, try again.'
    end
  end

  def valid_input?(input)
    raise InvalidInputError unless input.match?(/[a-zA-Z]/) && input.length == 1
  end

  def compare_input(letter)
    @word.value.chars.map { |game_word| game_word == letter ? letter : false }
  end

  def compare_score(score)
    score.include?(false)
  end
end

# Class to keep and maintain score
class Score
  attr_accessor :score

  def initialize
    @score = 5
  end

  def wrong_answer
    @score -= 1
    'Game over' if @score.zero?
  end
end

class InvalidInputError < StandardError
end

# Class to operate all the game's logic
class Hangman
  def initialize
    @word = Comparison.new('')
    @score = Score.new
    @guess = Comparison.new('')
  end

  def game_start
    puts PlayGame.intro
    @word = @word.words_generator
    puts "#{@word.value} is the word"
    puts Comparison.hide_string(@word)
    loop do
      @guess = @guess.player_input
      binding.pry
      @word.compare_input(@guess.value)
    end
  end
end

Hangman.new.game_start
