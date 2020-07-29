require './board.rb'
require './card.rb'
require 'pry'


class Game
    attr_accessor :turns

    def initialize
        @board = Board.new()
        @num_pairs_to_be_found = @board.board.flatten.length/4
        @found = 0
        @turns = 0
    end

    def run
        until won?
            play_round
        end
    end

    def won?
        @found == @num_pairs_to_be_found
    end

    def play_round
        puts "You have #{@num_pairs_to_be_found-@found} pairs left"
        @board.display_board
        turn
    end

    def turn
        first_guess = guess
        @board.display_board 
        second_guess = guess
        
        if first_guess.value == second_guess.value
            puts "You got a match!"
            @found+=1
            display_board
        else
            puts "Not a match"
            first_guess.hide
            second_guess.hide
        end
        @turns +=1
    end


    def guess
        puts "Please choose a card e.g. 0, 0"
        response = gets.chomp
        if valid_guess?(response)
            current_guess = valid_guess?(response)
            # binding.pry
            @board[current_guess].reveal
        else
            puts "Try that again"
            return guess
        end
        @board[current_guess]
    end

    def valid_guess?(guess)
        start_array = guess.split(",")
        if start_array.length != 2
            puts "That wasn't 2 numbers, correct format: 0, 0"
            return false
        elsif !start_array.all? {|ele| ele.to_i.is_a? Integer}
            puts "Those weren't numbers"
            return false
        end
        end_array = start_array.map(&:to_i) 
        previously_guessed?(end_array) #if not previously guessed returns the valid guess
    end

    def previously_guessed?(end_array)
        if @board[end_array].face_up
            puts "You have already guessed that card"
            return true
        else
            return end_array
        end
    end
end