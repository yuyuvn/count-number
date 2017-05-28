class Game
  @@mutex = Mutex.new

  include Mongoid::Document
  field :status, type: String, in: [:created, :playing, :ended]

  field :balls, type: Array

  embeds_many :clicks

  before_create :setup_game

  def setup_game
    _balls = Array.new
    rng_goddess = Random.new
    Settings.number_of_balls.times do |i|
      pos_x = rng_goddess.rand(Settings.ball_size, Settings.board_size.x-Settings.ball_size)
      pos_y = rng_goddess.rand(Settings.ball_size, Settings.board_size.y-Settings.ball_size)
      _balls << [pos_x, pos_y]
    end
    self.balls = _balls
  end

  def click click
    @@mutex.synchronize do
      last_ball = self.balls.last
      if (click.x-last_ball[0])^2 + (click.y-last_ball[1])^2 <= Settings.ball_size^2
        self.pop balls: -1
        self.clicks << click
      end
    end
  end
end
