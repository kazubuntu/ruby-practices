# frozen_string_literal: true

require_relative 'directory'
require_relative 'terminal'

directory = Directory.new
options = ARGV.getopts('arl')
terminal = Terminal.new(directory, options)
terminal.print_directory_entries
