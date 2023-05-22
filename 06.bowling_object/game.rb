# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(marks_of_game)
    @frames = build_frames(marks_of_game)
  end

  def build_frames(marks_of_game)
    marks_each_frames = marks_of_game.split(',').chunk_while { |after, before| after != 'X' && before != 'X' }.flat_map { |marks| marks.each_slice(2).to_a }
    marks_each_frames[9] += marks_each_frames.pop((marks_each_frames.size - 10)).flatten
    marks_each_frames.map { |marks_each_frame| Frame.new(*marks_each_frame) }
  end

  def score
    @frames.sum(&:score) + bonus
  end

  def bonus
    bonus_score = 0
    9.times do |index|
      bonus_score += @frames[index + 1].first_shot.score if @frames[index].spare?
      next unless @frames[index].strike?

      bonus_score += @frames[index + 1].first_shot.score
      bonus_score += if @frames[index + 1].strike? && index < 8
                       @frames[index + 2].first_shot.score
                     else
                       @frames[index + 1].second_shot.score
                     end
    end
    bonus_score
  end
end
