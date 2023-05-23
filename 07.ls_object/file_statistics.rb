# frozen_string_literal: true

require 'etc'

class FileStatistics
  attr_reader :mode, :nlink, :user, :group, :size, :mtime, :blocks

  def initialize(directory_entry)
    @stat = File.lstat(directory_entry)
    @mode = convert_mode
    @nlink = @stat.nlink
    @user = Etc.getpwuid(@stat.uid).name
    @group = Etc.getgrgid(@stat.gid).name
    @size = @stat.size
    @mtime = @stat.mtime.strftime('%_m月 %e %R')
    @blocks = @stat.blocks
  end

  private

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

  def convert_mode
    file_type = TYPE[@stat.ftype]
    file_permission = @stat.mode.to_s(8).slice(-3, 3).chars.map { |mode_number| PERMISSION[mode_number] }.join
    file_type + file_permission
  end
end
