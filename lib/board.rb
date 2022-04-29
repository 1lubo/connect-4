

class Board

    attr_accessor :board

    Symbols = { "1" => "\u{24F5}", "2" => "\u{24F6}", "3" => "\u{24F7}", "4" => "\u{24F8}",
            "5" => "\u{24F9}", "6" => "\u{24FA}", "7" => "\u{24FB}", "E" => "\u{26AB}", "P1" => "\u{26BE}",
            "P2" => "\u{1F3C0}"}
    Number_row_string = "#{Symbols['1']}  #{Symbols['2']}  #{Symbols['3']}  #{Symbols['4']}  #{Symbols['5']}  #{Symbols['6']}  #{Symbols['7']}"

    def initialize
        @board = Array.new(6) {Array.new(7)}
    end

    def draw_board
        board.each { |row| puts draw_row(row)}
        puts Number_row_string
    end

    def clear_board
        @board = Array.new(6) {Array.new(7)}
    end

    def draw_row(array_row)
        row_string = ""
        array_row.each do |item|
            if item.nil?
                row_string += "#{Symbols['E']} "
            elsif item == 1
                row_string += "#{Symbols['P1']} "
            elsif item == 2
                row_string += "#{Symbols['P2']} "
            end
        end
        row_string
    end

    def put_mark(player_number, player_choice)
        i = board.length - 1
        while i >= 0 do             
            if board[i][player_choice - 1].nil? 
                board[i][player_choice - 1] = player_number
                return true
            else
                i -= 1                
            end
        end
        
        return false
    end  
    
    def board_full?
        return -1 if board.flatten.all?
    end
    
    def check_column(player_choice)
        board[0][player_choice - 1].nil? ? true : false
    end

    def connect_four_by_row
        board.each do |row|
            a = row.each_cons(4).find { |a| a.uniq.size == 1 && !a.first.nil?}
            return a.first unless a.nil?
        end
        false
    end

    def connect_four_by_column
        board.transpose.each do |row|
            a = row.each_cons(4).find { |a| a.uniq.size == 1 && !a.first.nil?}
            return a.first unless a.nil?
        end
        false
    end

    def connect_four_by_diagonal_top_to_bottom
        diagonals = (0..board.size-4).map do |i|
            (0..board.first.size-1-i).map { |j| board[i+j][j] unless i + j > 5 }
        end.concat((1..board.size-3).map do |j|
        (0..board.first.size-j-1).map { |i| board[i][j+i] unless i + j > 6 }
        end)

        diagonals.each do |row|
            a = row.each_cons(4).find { |a| a.uniq.size == 1 && !a.first.nil?}
            return a.first unless a.nil?
        end
        false
    end

    def connect_four_by_diagonal_bottom_to_top

        diagonals = (1..board.size-3).map do |i| 
            (0..board.size - i).map { |j| board[board.size - i - j][j] unless j == board.size }
        end.concat((1..board.size - 3).map do |i| 
            (1..board.first.size - i).map { |j| board[board.size - j][j + i - 1] unless j == board.first.size}    
        end)

        diagonals.each do |row|
            a = row.each_cons(4).find { |a| a.uniq.size == 1 && !a.first.nil?}
            return a.first unless a.nil?
        end
        false
    end    

end

