require_relative '../lib/player.rb'

describe Player do

    describe '#initialize' do
       subject(:new_player)  { described_class.new('Adam', 1) }

       context 'when new Player is initialized' do

        it 'has a number' do
            player_number = new_player.instance_variable_get(:@number)
            expect(player_number).not_to be nil
        end

        it 'has a name' do
            player_name = new_player.instance_variable_get(:@name)
            expect(player_name).not_to be nil
        end

        it 'has a name which is a String' do
            player_name = new_player.instance_variable_get(:@name)
            expect(player_name).to be_a(String) 
        end
        end

    end

    describe '#player_input' do

        subject(:input) {described_class.new('Adam', 1)}
        error_message = "Input error! Please enter a number between 1 and 7."
        let (:invalid_input) { String.new('g \n') }
        let (:valid_input) { String.new('3 \n')}

        context 'when player input is valid' do

            before do
                allow(input).to receive(:gets).and_return(valid_input)
            end

            it 'stops loop and does not display error message' do                            
                expect(input).not_to receive(:puts).with(error_message)
                input.player_input
              end            

        end

        context 'when player input is valid' do
            
            before do
                allow(input).to receive(:gets).and_return(valid_input)
            end

            it 'stops loop and returns user input as integer' do                
                result = input.player_input
                expect(result).to eq valid_input.to_i
              end            

        end

        context 'when user inputs an incorrect value once, then a valid input' do
            
            before do                
                allow(input).to receive(:gets).and_return(invalid_input, valid_input)
            end

            it 'completes loop and displays error message once' do                
                expect(input).to receive(:puts).with(error_message).once
                input.player_input
            end            

        end

    end
end