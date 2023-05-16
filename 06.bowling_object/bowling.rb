# frozen_string_literal: true

require_relative 'game'

def main
  puts score(ARGV[0])
end

def score(argv)
  marks_of_game = argv.split(',')
  # 投球をフレーム単位に分ける。
  marks_each_frames = marks_of_game.chunk_while { |after, before| after != 'X' && before != 'X' }.flat_map { |marks| marks.each_slice(2).to_a }
  marks_each_frames[9] += marks_each_frames.pop((marks_each_frames.size - 10)).flatten

  Game.new(marks_each_frames).score
end

main
