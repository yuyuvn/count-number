class Click
  include Mongoid::Document

  belongs_to :user
  embedded_in :game

  field :x, type: Integer
  field :y, type: Integer
end
