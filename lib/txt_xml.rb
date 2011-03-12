# -*- coding: windows-1251 -*-
file_in = File.new(ARGV[0], mode = "r")
file_out = File.new(ARGV[1], mode = "w")
arr_ru = []
arr_en = []
begin
  while file_in.gets
    $_.strip!
    next if $_.size < 1 
    break if $_ == "-"
    arr_ru << $_
  end
  while file_in.gets
    $_.strip!
    next if $_.size < 1 
    break if $_ == "-"
    arr_en << $_
  end
  arr_ru.each_index do |i|
    if arr_ru[i] =~ /(.*?):(.*)/
      if $1 != "- Другие сведения"
        file_out.print $1
        file_out.puts ":"
        file_out.puts $2
        file_out.puts if $2.size > 0
      end
    end
    
    next if [1,2].include?(i)
    i -= 2 if i > 2
    if arr_en[i] != nil and arr_en[i] =~ /(.*?):(.*)/
      if $1 != "- Other"
        file_out.print $1
        file_out.puts ":"
        file_out.puts $2
        file_out.puts if $2.size > 0
      end
    end
  end
  file_out.puts
  file_out.puts "-"
  file_out.puts
  arr_ru, arr_en = [], []
end while file_in.gets 
