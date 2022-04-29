require_relative '../lib/board.rb'

describe Board do

    describe '#initialize' do
       subject(:new_board)  { described_class.new }
       context 'when new board is initialized' do

        it 'has 6 rows' do
            rows = new_board.instance_variable_get(:@board).length
            expect(rows).to eq 6
        end

        it 'has 7 columns' do
            each_row_has_7_columns = new_board.instance_variable_get(:@board).all? { |row| row.length == 7 }
            expect(each_row_has_7_columns).to be true
        end

        it 'is empty' do
            each_row_is_empty = new_board.instance_variable_get(:@board).all? { |row| row.each { |e| e.nil? } } 
            expect(each_row_is_empty).to be true
        end

       end
    end

    describe '#draw_board' do
        context 'when draw_board is called' do
        subject(:drawing_board)  { described_class.new }
            it 'draw_row is called 6 times' do
                expect(drawing_board).to receive(:draw_row).exactly(6).times
                drawing_board.draw_board
            end
        end
    end

    describe '#put_mark' do
        
        context 'when player selects a column to put mark' do
            subject(:mark_board) { described_class.new }
            
            it 'will return false if column is already full' do
                mark_board.board[0][0] = 1
                mark_board.board[1][0] = 1
                mark_board.board[2][0] = 1
                mark_board.board[3][0] = 1
                mark_board.board[4][0] = 1
                mark_board.board[5][0] = 1
                result = mark_board.put_mark(1, 1)
                expect(result).to eq false
            end

            it 'will return true if there is at least one empty space in column' do
                mark_board.board[0][0] = 1
                mark_board.board[1][0] = 1
                mark_board.board[2][0] = 1
                mark_board.board[3][0] = 1
                mark_board.board[4][0] = 1
                result = mark_board.put_mark(1, 1)
                expect(result).to eq true
            end
           
        end        
    end

    describe '#board_full?' do

        context 'when the board is empty' do
            subject(:empty_board) { described_class.new }

            it 'will return nil' do
                result = empty_board.board_full?
                expect(result).to be nil
            end
        end

        context 'when there are a number of marks on the board' do
            subject(:not_empty_board) { described_class.new }

            it 'will return nil' do
                for i in rand(1..10)..10 do
                    not_empty_board.put_mark([1,2].sample, rand(1..7))
                end
                result = not_empty_board.board_full?
                expect(result).to be nil
            end
        end

        context 'when the board is full' do
            subject(:full_board) { described_class.new }

            it 'will retturn -1' do
                for i in 0..5 do
                    for j in 1..7 do
                        full_board.put_mark(1,j) 
                    end
                end
                result = full_board.board_full?
                expect(result).to eq -1
            end
        end

    end

    describe '#connect_four_by_row' do
        subject(:row_board) { described_class.new }
        context 'when there are no 4 consecutive marks in any row' do           

            it 'will return false' do
                result = row_board.connect_four_by_row
                expect(result).to be false
            end
        end

        context 'when there are 4 consecutive Player1 marks in a row' do
            
            it 'will return 1' do                
                row_board.put_mark(1,1)
                row_board.put_mark(1,2)
                row_board.put_mark(1,3)
                row_board.put_mark(1,4)
                result = row_board.connect_four_by_row
                expect(result).to eq 1
            end

            it 'will not return 2' do 
                row_board.put_mark(1,1)
                row_board.put_mark(1,2)
                row_board.put_mark(1,3)
                row_board.put_mark(1,4)
                result = row_board.connect_four_by_row
                expect(result).not_to eq 2 
            end

            it 'will not false' do
                row_board.put_mark(1,1)
                row_board.put_mark(1,2)
                row_board.put_mark(1,3)
                row_board.put_mark(1,4)
                result = row_board.connect_four_by_row
                expect(result).not_to be false
            end
        end

        context 'when there are 4 consecutive Player2 marks in a row' do
            
            it 'will return 2' do                
                row_board.put_mark(2,1)
                row_board.put_mark(2,2)
                row_board.put_mark(2,3)
                row_board.put_mark(2,4)
                result = row_board.connect_four_by_row
                expect(result).to eq 2
            end

            it 'will not return 1' do 
                row_board.put_mark(2,1)
                row_board.put_mark(2,2)
                row_board.put_mark(2,3)
                row_board.put_mark(2,4)
                result = row_board.connect_four_by_row
                expect(result).not_to eq 1
            end

            it 'will not false' do
                row_board.put_mark(2,1)
                row_board.put_mark(2,2)
                row_board.put_mark(2,3)
                row_board.put_mark(2,4)
                result = row_board.connect_four_by_row
                expect(result).not_to be false
            end
        end
    end

    describe '#connect_four_by_column' do
        subject(:column_board) { described_class.new }    
        context 'when there are no 4 consecutive marks in any column' do
            

            it 'will return false' do
                result = column_board.connect_four_by_column
                expect(result).to be false
            end
        end

        context 'when there are 4 consecutive Player1 marks in a column' do
            
            it 'will return 1' do                
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                result = column_board.connect_four_by_column
                expect(result).to eq 1
            end

            it 'will not return 2' do 
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                result = column_board.connect_four_by_column
                expect(result).not_to eq 2 
            end

            it 'will not false' do
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                column_board.put_mark(1,2)
                result = column_board.connect_four_by_column
                expect(result).not_to be false
            end
        end

        context 'when there are 4 consecutive Player2 marks in a column' do
            
            it 'will return 2' do                
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                result = column_board.connect_four_by_column
                expect(result).to eq 2
            end

            it 'will not return 1' do 
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                result = column_board.connect_four_by_column
                expect(result).not_to eq 1
            end

            it 'will not false' do
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                column_board.put_mark(2,3)
                result = column_board.connect_four_by_column
                expect(result).not_to be false
            end
        end
    end

    describe '#connect_four_by_diagonal_top_to_bottom' do
        subject(:diagonal_board_1) { described_class.new }
        context 'when there are no 4 consecutive marks in any diagonal' do
            

            it 'will return false' do
                result = diagonal_board_1.connect_four_by_diagonal_top_to_bottom
                expect(result).to be false
            end
        end

        context 'when there are 4 consecutive Player1 marks in a diagonal' do
            
            it 'will return 1' do                
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,4)
                diagonal_board_1.put_mark(1,4)
                diagonal_board_1.put_mark(1,5)
                result = diagonal_board_1.connect_four_by_diagonal_top_to_bottom
                expect(result).to eq 1
            end

            it 'will not return 2' do 
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,4)
                diagonal_board_1.put_mark(1,4)
                diagonal_board_1.put_mark(1,5)
                result = diagonal_board_1.connect_four_by_diagonal_top_to_bottom
                expect(result).not_to eq 2
            end

            it 'will not be false' do
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,2)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,3)
                diagonal_board_1.put_mark(1,4)
                diagonal_board_1.put_mark(1,4)
                diagonal_board_1.put_mark(1,5)
                result = diagonal_board_1.connect_four_by_diagonal_top_to_bottom
                expect(result).not_to be false
            end
        end

        context 'when there are 4 consecutive Player2 marks in a diagonal' do
            
            it 'will return 2' do                
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,4)
                diagonal_board_1.put_mark(2,4)
                diagonal_board_1.put_mark(2,5)
                result = diagonal_board_1.connect_four_by_diagonal_top_to_bottom
                expect(result).to eq 2
            end

            it 'will not return 1' do 
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,4)
                diagonal_board_1.put_mark(2,4)
                diagonal_board_1.put_mark(2,5)
                result = diagonal_board_1.connect_four_by_diagonal_top_to_bottom
                expect(result).not_to eq 1
            end

            it 'will not be false' do
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,2)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,3)
                diagonal_board_1.put_mark(2,4)
                diagonal_board_1.put_mark(2,4)
                diagonal_board_1.put_mark(2,5)
                result = diagonal_board_1.connect_four_by_diagonal_top_to_bottom
                expect(result).not_to be false
            end
        end
    end

    describe '#connect_four_by_diagonal_bottom_to_top' do
        subject(:diagonal_board_2) { described_class.new }
        context 'when there are no 4 consecutive marks in any diagonal' do
            

            it 'will return false' do
                result = diagonal_board_2.connect_four_by_diagonal_bottom_to_top
                expect(result).to be false
            end
        end

        context 'when there are 4 consecutive Player1 marks in a diagonal' do
            
            it 'will return 1' do                
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,2)
                diagonal_board_2.put_mark(1,2)
                diagonal_board_2.put_mark(1,1)
                result = diagonal_board_2.connect_four_by_diagonal_bottom_to_top
                expect(result).to eq 1
            end

            it 'will not return 2' do 
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,2)
                diagonal_board_2.put_mark(1,2)
                diagonal_board_2.put_mark(1,1)
                result = diagonal_board_2.connect_four_by_diagonal_bottom_to_top
                expect(result).not_to eq 2
            end

            it 'will not be false' do
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,4)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,3)
                diagonal_board_2.put_mark(1,2)
                diagonal_board_2.put_mark(1,2)
                diagonal_board_2.put_mark(1,1)
                result = diagonal_board_2.connect_four_by_diagonal_bottom_to_top
                expect(result).not_to be false
            end
        end

        context 'when there are 4 consecutive Player2 marks in a diagonal' do
            
            it 'will return 2' do                
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,2)
                diagonal_board_2.put_mark(2,2)
                diagonal_board_2.put_mark(2,1)
                result = diagonal_board_2.connect_four_by_diagonal_bottom_to_top
                expect(result).to eq 2
            end

            it 'will not return 1' do 
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,2)
                diagonal_board_2.put_mark(2,2)
                diagonal_board_2.put_mark(2,1)
                result = diagonal_board_2.connect_four_by_diagonal_bottom_to_top
                expect(result).not_to eq 1
            end

            it 'will not be false' do
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,4)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,3)
                diagonal_board_2.put_mark(2,2)
                diagonal_board_2.put_mark(2,2)
                diagonal_board_2.put_mark(2,1)
                result = diagonal_board_2.connect_four_by_diagonal_bottom_to_top
                expect(result).not_to be false
            end
        end
    end    

end