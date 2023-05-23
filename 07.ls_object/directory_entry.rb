# frozen_string_literal: true

require_relative 'file_statistics'

class DirectoryEntry
  attr_reader :name, :stat

  def initialize(directory_entry)
    @name = directory_entry
    @stat = FileStatistics.new(directory_entry)
  end
end
