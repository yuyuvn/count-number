class GameChannel < ApplicationCable::Channel
  def subscribed
  end

  def follow params
    game = Game.find params["id"]
    stream_for game
  end

  def unfollow

  end
end
