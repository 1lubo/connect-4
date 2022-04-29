require_relative '../lib/game.rb'

describe Game do

    describe '#initialize' do       
        subject(:new_game) { described_class.new }

        context 'when a new game is initialized' do
            
            it 'a new board will be created' do
                game_board = new_game.instance_variable_get(:@board)
                expect(game_board).to be_a(Board)
            end

            it 'winner? will be false' do                
                winner = new_game.instance_variable_get(:@winner)
                expect(winner).to be nil                
            end
        end

        

    end

    describe '#start_game' do
        context 'when a new game is started' do
            subject(:a_game) { described_class.new }
            let (:yes) { String.new('y \n')}
            let (:question) { String.new("\nWould you like to play a game of Connect Four? (y / n)")}

            before do
                allow(a_game).to receive(:gets).and_return(yes)
            end

            it 'the introduction will be displayed' do
                expect(a_game).to receive(:introduction).once
                a_game.start_game
            end            
           
        end

        context 'when user input is valid' do
            subject(:b_game) { described_class.new }
            let (:valid_input) { String.new('y \n')}
            let (:invalid_input) { String.new('5 \n')}

            before do
                allow(b_game).to receive(:gets).and_return(valid_input)
            end

            it 'stops loop and returns true' do
                result = b_game.start_game
                expect(result).to be true
            end            

        end
        
        
    end



end
