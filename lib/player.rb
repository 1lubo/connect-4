require_relative './board.rb'

class Player

    attr_accessor :number, :name

    def initialize(name, number)
        @name = name
        @number = number        
    end

    def player_input(board)
        loop do
          user_input = gets.chomp          
            if user_input.match?(/^[1-7]{1}$/)
                column_empty = board.check_column(user_input.to_i)
                if column_empty
                    return user_input.to_i                
                else
                    puts "Column us full. Please make another choice."
                end
            else
                puts "Input error! Please enter a number between 1 and 7."
            end
        end
    end    

end

#a = Board.new
#pl = Player.new('Adam', 1)
#
#a.put_mark(1,1)
#a.put_mark(1,1)
#a.put_mark(1,1)
#a.put_mark(1,1)
#a.put_mark(1,1)
#a.put_mark(1,1)
#a.draw_board
#pl.player_input(a)