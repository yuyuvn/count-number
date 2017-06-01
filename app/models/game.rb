class Game
  include Mongoid::Document

  field :status, type: String, default: "waiting"
  field :balls, type: Array

  embeds_many :clicks

  before_create :setup_game

  def setup_game
    _balls = Array.new
    rng_goddess = Random.new
    Settings.number_of_balls.times do |i|
      pos_x = Settings.ball_size + rng_goddess.rand(Settings.board_size.x-Settings.ball_size)
      pos_y = Settings.ball_size + rng_goddess.rand(Settings.board_size.y-Settings.ball_size)
      _balls << [pos_x, pos_y]
    end
    self.balls = _balls
  end

  def start
    self.update status: "started"
    GameUpdateJob.perform_later self.id.to_s
  end

  def click click
    last_ball = self.balls.last
    if (click.x-last_ball[0])^2 + (click.y-last_ball[1])^2 <= Settings.ball_size^2
      self.pop balls: -1
      self.clicks << click
    end
  end
end
