# frozen_string_literal: true

require_relative 'game'

def score(marks_of_game)
  puts Game.new(marks_of_game).score
end

score(ARGV[0])
