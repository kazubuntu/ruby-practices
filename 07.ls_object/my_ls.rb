# frozen_string_literal: true

require_relative 'directory_entry'
require 'optparse'

class MyLs
  def initialize
    @options = ARGV.getopts('arl')
    @directory_entries = read_current_directory
  end

  def print_directory_entries
    return print_long_list if @options['l']

    transpose_directory_entries.each { |entries| puts entries.join }
  end

  private

  def read_current_directory
    directory_entries = @options['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    directory_entries.reverse! if @options['r']
    directory_entries.map do |directory_entry|
      DirectoryEntry.new(directory_entry)
    end
  end

  COLMUN_SIZE = 3.0
  def transpose_directory_entries
    slice_size = (@directory_entries.size / COLMUN_SIZE).ceil
    @directory_entries.each_slice(slice_size).map do |entries|
      max_width = entries.inject(0) { |result, entry| [result, entry.name.size].max }
      entries.map { |entry| entry.name.ljust(max_width + 2) } + Array.new(slice_size - entries.size)
    end.transpose
  end

  def print_long_list
    total_blocks_size = @directory_entries.sum { |directory_entry| directory_entry.stat.blocks }
    puts "合計 #{total_blocks_size}"
    max_width_of_nlink = @directory_entries.inject(0) { |result, entry| [result, entry.stat.nlink.to_s.length].max }
    max_width_of_size = @directory_entries.inject(0) { |result, entry| [result, entry.stat.size.to_s.length].max }
    @directory_entries.each do |directory_entry|
      puts [
        directory_entry.stat.mode,
        directory_entry.stat.nlink.to_s.rjust(max_width_of_nlink),
        directory_entry.stat.user,
        directory_entry.stat.group,
        directory_entry.stat.size.to_s.rjust(max_width_of_size),
        directory_entry.stat.mtime,
        directory_entry.name
      ].join(' ')
    end
  end
end

MyLs.new.print_directory_entries
