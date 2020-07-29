require './card.rb'
require 'pry'
class Board
    attr_reader :board 

    def initialize
        @board = create
        populate
    end

    def populate
        cards_to_be_placed = generate_pairs
        while cards_to_be_placed.length > 0
            card = @board.flatten.sample
            if card.value == nil
                card.value = cards_to_be_placed.pop
            end
        end
        @board.flatten.each do |card|
            if card.value == nil
                card.value = :X
            end
        end
    end

    def [](nums)
        @board[nums[0]][nums[1]]
    end

    def generate_pairs
        needed_pairs = @board.flatten.length/4
        values_to_put_on_board = []
        stock_values= [:A,:K, :Q, :J, :L, :M, :N]
        (needed_pairs).times do
            values_to_put_on_board << stock_values.shift
        end
        values_to_put_on_board+= values_to_put_on_board
    end

    def create
        Array.new(4) {Array.new(4) {Card.new()}}
    end

    def display_board
        puts "    0   1   2   3"
        @board.each_with_index do |card_row, row_index|
            cards = []
            card_row.each do |card|
                if card.face_up
                    cards << card.value
                else
                    cards << :_
                end
            end
            puts "#{row_index} #{cards}"
        end
    end

end