require_relative './game.rb'

new_game = Game.new

play = new_game.start_game
while play 
    puts `clear`
    new_game.create_players
    new_game.winner = new_game.game_loop    
    new_game.board.draw_board
    if new_game.winner > 0
        puts "#{new_game.players[new_game.winner - 1].name} wins!"
    else
        puts "It's a tie!"
    end
    play = new_game.continue
end
puts `clear`
puts "Thanks. Bye"