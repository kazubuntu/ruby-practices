# frozen_string_literal: true

require_relative 'directory'
require_relative 'terminal'

directory = Directory.new
terminal = Terminal.new
terminal.print_directory_entries(directory)
