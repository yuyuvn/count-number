class GameUpdateJob < ApplicationJob
  queue_as :default

  def perform(game_id)
    game = Game.find game_id
    GameChannel.broadcast_to game, balls: game.balls, status: game.status
  end
end
