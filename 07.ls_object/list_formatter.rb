# frozen_string_literal: true

class ListFormatter
  def initialize(directory, options)
    @directory = directory
    @options = options
  end

  COLUMN_SIZE = 3.0
  def format
    @directory.reject_hidden_files unless @options['a']
    @directory.reverse_directory_entries if @options['r']
    return long_list(@directory.directory_entries) if @options['l']

    short_list(@directory.directory_entries, COLUMN_SIZE)
  end

  private

  def short_list(directory_entries, column_size)
    row_size = (directory_entries.size / column_size).ceil
    directory_entries.each_slice(row_size).map do |entries|
      max_width = entries.inject(0) { |result, entry| [result, entry.name.size].max }
      entries.map { |entry| entry.name.ljust(max_width + 2) } + Array.new(row_size - entries.size)
    end.transpose.map(&:join)
  end

  def long_list(directory_entries)
    total_blocks = directory_entries.sum(&:blocks)
    max_width_of_nlink = directory_entries.inject(0) { |result, entry| [result, entry.nlink.to_s.length].max }
    max_width_of_size = directory_entries.inject(0) { |result, entry| [result, entry.size.to_s.length].max }
    directory_entries.map do |directory_entry|
      [
        directory_entry.mode,
        directory_entry.nlink.to_s.rjust(max_width_of_nlink),
        directory_entry.user,
        directory_entry.group,
        directory_entry.size.to_s.rjust(max_width_of_size),
        directory_entry.mtime,
        directory_entry.name
      ].join(' ')
    end.unshift(["合計 #{total_blocks}"])
  end
end
