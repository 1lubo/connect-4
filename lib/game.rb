
require_relative './board.rb'
require_relative './player.rb'

class Game

    attr_reader :board
    attr_accessor :players, :winner
    
    def initialize        
        @board = Board.new
        @winner = nil
        @players = []
    end

    def start_game
        introduction
        puts "\nWould you like to play a game of Connect Four? (y / n)"
        loop do
            start = gets.chomp          
            if start.downcase.match?('y')    
                return true
            elsif start.downcase.match?('n')
                return false
            end
            puts "Input error! Please enter 'y' or 'n'."
        end
        false
    end

    def continue
        puts "\nWould you like to play another game of Connect Four? (y / n)"
        loop do
            start = gets.chomp          
            if start.downcase.match?('y') 
                players.clear
                board.clear_board
                return true
            elsif start.downcase.match?('n')
                return false
            end
            puts "Input error! Please enter 'y' or 'n'."
        end
        false
    end

    def game_loop
        puts `clear`
        loop do
            for i in 0..1
                board.draw_board   
                puts "\n#{players[i].name} please make your choice." 
                player_turn = players[i].player_input(board)
                board.put_mark(players[i].number, player_turn)
                winner = winner?
                puts `clear`
                return winner if winner 
            end
        end
    end

    def winner?
        board.connect_four_by_row || board.connect_four_by_column ||
        board.connect_four_by_diagonal_top_to_bottom || board.connect_four_by_diagonal_bottom_to_top || 
        board.board_full?
    end

    def create_players        
        for i in 1..2 
            players << Player.new(get_name(i), i)
        end
    end

    def get_name(num)
        puts "Enter name for player #{num}"
        loop do
            name = gets.chomp
            return name if name.length >= 1
            puts "Please enter at least one character"
        end
        false
    end
        
    def introduction
        puts"\n\e[34mConnect Four is a two-player connection board game, in which the players take turns dropping colored tokens into a seven-column, six-row vertically suspended grid.\nThe pieces fall straight down, occupying the lowest available space within the column.\nThe objective of the game is to be the first to form a horizontal, vertical, or diagonal line of four of one's own tokens.\e[0m"                
    end
    
end