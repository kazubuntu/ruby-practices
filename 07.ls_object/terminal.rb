# frozen_string_literal: true

require 'optparse'
require_relative 'list_formatter'

class Terminal
  def initialize
    @options = ARGV.getopts('arl')
    @formatter = ListFormatter.new
  end

  COLUMN_SIZE = 3.0
  def print_directory_entries(directory)
    directory.reject_hidden_files unless @options['a']
    directory.reverse_directory_entries if @options['r']
    return print_long_list(directory.directory_entries) if @options['l']

    @formatter.short_list(directory.directory_entries, COLUMN_SIZE).each { |list| puts list }
  end

  private

  def print_long_list(directory_entries)
    total_blocks = directory_entries.sum(&:blocks)
    puts "合計 #{total_blocks}"
    @formatter.long_list(directory_entries).each { |list| puts list }
  end
end
