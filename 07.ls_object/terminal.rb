# frozen_string_literal: true

require 'optparse'
require_relative 'list_formatter'

class Terminal
  def initialize(directory, options)
    @directory = directory
    @formatter = ListFormatter.new(@directory, options)
  end

  def print_directory_entries
    lists = @formatter.format
    lists.each { |list| puts list }
  end
end
