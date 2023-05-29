# frozen_string_literal: true

require_relative 'directory_entry'

class Directory
  attr_reader :directory_entries

  def initialize
    @directory_entries = read_directory
  end

  def reject_hidden_files
    @directory_entries.reject! { |directory_entry| directory_entry.name.start_with?('.') }
  end

  def reverse_directory_entries
    @directory_entries.reverse!
  end

  private

  def read_directory
    directory_entries = Dir.glob('*', File::FNM_DOTMATCH)
    directory_entries.map do |directory_entry|
      DirectoryEntry.new(directory_entry)
    end
  end
end
