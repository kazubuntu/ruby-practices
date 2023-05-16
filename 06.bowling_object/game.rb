# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(marks_each_frames)
    @frames = marks_each_frames.map { |marks_each_frame| Frame.new(*marks_each_frame) }
  end

  def score
    @frames.sum(&:score) + bonus
  end

  def bonus
    bonus_score = 0
    9.times do |index|
      bonus_score += @frames[index + 1].first_shot.score if @frames[index].spear?
      next unless @frames[index].strike?

      bonus_score += @frames[index + 1].first_shot.score
      bonus_score += if @frames[index + 1].strike?
                       @frames[index + 2].first_shot.score
                     else
                       @frames[index + 1].second_shot.score
                     end
    end
    bonus_score
  end
end
