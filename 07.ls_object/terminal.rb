# frozen_string_literal: true

require 'optparse'
require_relative 'list_formatter'

class Terminal
  def initialize
    @options = ARGV.getopts('arl')
    @formatter = ListFormatter.new(@options)
  end

  def print_directory_entries(directory)
    lists = @formatter.format(directory)
    lists.each { |list| puts list }
  end
end
