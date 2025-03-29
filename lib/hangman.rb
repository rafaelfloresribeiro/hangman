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

  def compare_input(letter, word)
    word.chars.map { |game_word| game_word == letter ? letter : false }
  end

  def compare_score(score)
    score.include?(false)
  end

  def self.p_current_word(user_guess)
    user_guess.map { |letters| letters == false ? '_ ' : letters }.join
  end

  def self.concat_word(last_guess, current_guess)
    result_value = Array.new(last_guess.length, false)
    last_guess.each_with_index { |guess, index| result_value[index] = guess if guess != false }
    current_guess.each_with_index { |guess, index| result_value[index] = guess if guess != false }
    result_value
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
    @score = 'Game over' if @score.zero?
  end
end

class InvalidInputError < StandardError
end

# Class to operate all the game's logic
class Hangman
  def initialize
    @word = Comparison.new('')
    @guess = Comparison.new('')
    @score = Score.new
    @iterative_guess = Comparison.new('')
  end

  def play_intro
    puts PlayGame.intro
    @word = @word.words_generator
    puts "#{@word.value} is the word"
    puts Comparison.hide_string(@word)
  end

  def play_round
    @guess = @guess.player_input
    result = @guess.compare_input(@guess.value, @word.value)
    puts Comparison.p_current_word(result)
    # segundo loop
    @iterative_guess = result
    @guess = @guess.player_input
    result = @guess.compare_input(@guess.value, @word.value)
    @iterative_guess = Comparison.concat_word(@iterative_guess, result)
    puts Comparison.p_current_word(@iterative_guess)
  end

  # por algum motivo ta me irritando que eu to usando @values.values no lugar de so usar as variaveis de classes para alterarem os proprios valores
  # sem terem de terem de ser redesignadas. Se acalme disso. Se quiser arrumar, arrume depois.
  # Por agora. O que voce tem que fazer e testar se o concat funciona, e colocar os proximos rounds para funcionar

  def calculate_score
    if result.any?
      p 'vida permanece'
    else
      @score.wrong_answer
      p '-1 de vida'
      p @score.score
    end
  end

  def game_start
    play_intro
    play_round
    calculate_score
    loop do
      play_round
      calculate_score
    end
  end
end

Hangman.new.game_start 


