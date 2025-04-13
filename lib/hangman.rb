require 'csv'
require 'pry-byebug'
require 'yaml'
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
  def serialize
    {
      'value' => @value
    }
  end

  def self.deserialize(object)
    new(object['value'])
  end

  def words_generator
    dictionary = File.open('../files/google-10000-english-no-swears.txt')
    word_map = dictionary.readlines.map { |word| word.chomp if word.chomp.length >= 4 && word.chomp.length <= 11 }
    word_map.compact.sample
  end

  def self.hide_string(string)
    string.chars.map { '_ ' }.join
  end

  def self.ask_input
    'type a character'
  end

  def self.player_input
    loop do
      puts ask_input
      answer = gets.chomp
      valid_input?(answer)
      break answer
    rescue InvalidInputError
      puts 'Invalid input, try again.'
    end
  end

  def self.valid_input?(input)
    raise InvalidInputError unless input.match?(/[a-zA-Z]/) && input.length == 1
  end

  def self.compare_input(letter, word)
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

  def initialize(score = 5)
    @score = score
  end

  def wrong_answer
    @score -= 1
    @score = 'Game over' if @score.zero?
  end
end

class InvalidInputError < StandardError
end

class GameOver < StandardError
end

# Class to operate all the game's logic
class Hangman
  def initialize
    @word = Comparison.new
    @guess = nil
    @score = Score.new
    @iterative_guess = nil
    @advance_round = false
    @result = nil
    @guess_array = []
  end

  def toggle_round
    @advance_round = !@advance_round
  end

  def play_intro
    puts PlayGame.intro
    @word = @word.words_generator
    puts "#{@word} is the word"
    puts Comparison.hide_string(@word)
  end

  def play_round
    @guess = Comparison.player_input
    @guess_array << @guess
    @result = Comparison.compare_input(@guess, @word)
    if @advance_round == false
      puts Comparison.p_current_word(@result)
      @iterative_guess = @result
    else
      @iterative_guess = Comparison.concat_word(@iterative_guess, @result)
      puts Comparison.p_current_word(@iterative_guess)
    end
  end

  def calculate_score
    @score.wrong_answer if @result.any? == false
    end_game unless @score.score.instance_of?(Integer)
  end

  def end_game
    puts 'Game over'
    exit
  end

  def game_state_evaluator
    word = @word
    user_guess = @iterative_guess.join
    end_game if word == user_guess
  end

  def print_guesses
    puts "Your previous guesses was/were: #{@guess_array}. Current life: #{@score.score}"
  end

  def save_game
    user_save = {
      'guess' => @guess,
      'score' => @score,
      'word' => @word,
      'current_guess' => @iterative_guess,
      'advance_round' => @advance_round,
      'result' => @result,
      'guess_array' => @guess_array
    }
    File.write('user_save.yaml', user_save.to_yaml)
  end

  def self.load_game
    load_file = File.read('user_save.yaml')
    load_file = YAML.safe_load(load_file, permitted_classes: [Score])
    @guess = load_file['guess']
    @word = load_file['word']
    @score = load_file['score'].score
    @iterative_guess = load_file['iterative_guess']
    @advance_round = load_file['advance_round']
    @result = load_file['result']
    @guess_array = load_file['guess_array']
  end

  def game_start
    play_intro
    play_round
    calculate_score
    toggle_round
    loop do
      print_guesses
      play_round
      calculate_score
      game_state_evaluator
      binding.pry
      Hangman.load_game
    end
  end
end

Hangman.new.game_start
