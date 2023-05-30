# frozen_string_literal: true

require 'etc'

class DirectoryEntry
  attr_reader :name

  def initialize(directory_entry)
    @name = directory_entry
    @stat = File.lstat(@name)
  end

  TYPE = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }.freeze
  PERMISSION = {
    '7' => 'rwx',
    '6' => 'rw-',
    '5' => 'r-x',
    '4' => 'r--',
    '3' => '-wx',
    '2' => '-w-',
    '1' => '--x',
    '0' => '---'
  }.freeze

  def mode
    file_type = TYPE[@stat.ftype]
    file_permission = @stat.mode.to_s(8).slice(-3, 3).chars.map { |mode_number| PERMISSION[mode_number] }.join
    file_type + file_permission
  end

  def nlink
    @stat.nlink
  end

  def user
    Etc.getpwuid(@stat.uid).name
  end

  def group
    Etc.getgrgid(@stat.gid).name
  end

  def size
    @stat.size
  end

  def mtime
    @stat.mtime.strftime('%_m月 %e %R')
  end

  def blocks
    @blocks = @stat.blocks
  end
end
