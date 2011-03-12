def main_read 
  article = Hash.new("")
  article[:section_rus] = nil
  article[:section_en] = nil
  article[:pages] = nil
  article[:type] = nil
  article[:authors] = nil
  article[:title_rus] = nil
  article[:title_en] = nil
  article[:summary_rus] = nil
  article[:summary_en] = nil
  article[:keywords_rus] = nil
  article[:keywords_en] = nil
  article[:lists] = nil
  articles = []
  str = ""
  nstr = 0
  @fin.gets
  while true
    str = ""
    break if $_ == nil
    if $_.strip == "-"
      articles << article.dup
      article.clear
      article[:section_rus] = nil
      article[:section_en] = nil
      article[:pages] = nil
      article[:type] = nil
      article[:authors] = nil
      article[:title_rus] = nil
      article[:title_en] = nil
      article[:summary_rus] = nil
      article[:summary_en] = nil
      article[:keywords_rus] = nil
      article[:keywords_en] = nil
      article[:lists] = nil
      @fin.gets
      next
    end
    if $_ =~ /(^[a-l])\).*?:/
      if $1 == "a"
  ##################section_rus
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/
            if str.size < 1
               @flog.puts_utf16 "main_read. 2: Error in line #{$.}: #{$_.chomp}\nNo section_rus." if @flog
              break
            end 
            article[:section_rus] = str.strip
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 3: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "b"
  ##################section_en
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/
            if str.size < 1
              @flog.puts_utf16 ""
 "main_read. 4: Error in line #{$.}: #{$_.chomp}\nNo section_en." if @flog
              break
            end
            article[:section_en] = str.strip
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 5: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "c"
  ##################pages
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/
            if str.strip.size < 1
              $stderr.puts "main_read. 6: Error in line #{$.}: #{$_.chomp}\nNo pages."
              break
            end
            if str.strip =~ /(\d+)[^\d]*(\d*)/
              if $2 != ""
                if $1.to_i < 1 or $2.to_i < 1 or $2.to_i < $1.to_i
                  $stderr.puts "main_read. 7: Error in str #{$.}: #{str}\nWrong pages."
                elsif $2.to_i == $1.to_i
                  article[:pages] = [$1.to_i]
                else
                  article[:pages] = [$1.to_i, $2.to_i]
                end
              else
                if $1.to_i < 1 
                  $stderr.puts "main_read. 8: Error in str #{$.}: #{str}\nWrong pages."
                else
                  article[:pages] = [$1.to_i]
                end
              end
            else
              $stderr.puts "main_read. 9: Error in str #{$.}: #{str}\nWrong pages."
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 10: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "d"
  ##################type
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/
            if str.strip.size < 1
              $stderr.puts "main_read. 11: Error in line #{$.}: #{$_.chomp}\nNo type."
              break
            end
            article[:type] = str.strip
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 13: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "e"
  ##################author
        article[:authors] = []
        str = ""
        nstr = 0
        author_index = 0
        article[:authors] << Hash.new()
        AUTHOR_SYM.each{|i| article[:authors][author_index][i] = nil}
        @fin.gets
        while true
# !!!!!!!!!!!!!!!add many authors
          if $_ =~ /^-/
            case $_.strip[0..1]
            when "-a"
              if nstr > 0
                author_index += 1
                article[:authors] << Hash.new()
                AUTHOR_SYM.each{|i| article[:authors][author_index][i] = nil}
              end
              nstr = 0
            when "-b"
              if nstr > 0
                author_index += 1
                article[:authors] << Hash.new()
                AUTHOR_SYM.each{|i| article[:authors][author_index][i] = nil}
              end
              nstr = 1
            when "-c"
              if nstr > 1
                author_index += 1
                article[:authors] << Hash.new()
                AUTHOR_SYM.each{|i| article[:authors][author_index][i] = nil}
              end
              nstr = 2
            when "-d"
              if nstr > 2
                author_index += 1
                article[:authors] << Hash.new()
                AUTHOR_SYM.each{|i| article[:authors][author_index][i] = nil}
              end
              nstr = 3
            when "-e"
              if nstr > 3
                author_index += 1
                article[:authors] << Hash.new()
                AUTHOR_SYM.each{|i| article[:authors][author_index][i] = nil}
              end
              nstr = 4
            when "-f"
              if nstr > 4
                author_index += 1
                article[:authors] << Hash.new()
                AUTHOR_SYM.each{|i| article[:authors][author_index][i] = nil}
              end
              nstr = 5
            else
              $stderr.puts "13.1: Error in authors: Wrong beginning. #{$.}"
              nstr += 1
            end
            while @fin.gets
              if $_ =~ /^-/
                if str.strip.size < 1
                  @flog.puts_utf16 "main_read. 14: Error in line #{$.}: #{$_.chomp}\nNo author #{nstr}." if @flog
                else
                  article[:authors][author_index][AUTHOR_SYM[nstr]] = str.strip
                  str = ""
                end
                break 
              end
              if $_ =~ /^[a-l]\)/
                if str.strip.size < 1
                  @flog.puts_utf16 "main_read. 14: Error in line #{$.}: #{$_.chomp}\nNo author #{nstr}." if @flog
                else
                  article[:authors][author_index][AUTHOR_SYM[nstr]] = str.strip
                end
                if nstr != 5
                  $stderr.puts "main_read. 16: Error in line #{$.}: #{$_.chomp}\nWrong number of Author: #{nstr}."
                end
                break
              end
              str += $_.chomp
            end
          elsif $_ =~ /^[a-l]\)/
            if nstr != 5
              $stderr.puts "main_read. 16: Error in line #{$.}: #{$_.chomp}\nWrong number of Author: #{nstr}."
            end
            break
          else
            @fin.gets
          end
        end

      elsif $1 == "f"
  ##################title_rus
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              @flog.puts_utf16 "main_read. 17: Error in line #{$.}: #{$_.chomp}\nNo title_rus." if @flog
            else
              article[:title_rus] = str.strip
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 18: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "g"
  ##################title_en
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              @flog.puts_utf16 "main_read. 19: Error in line #{$.}: #{$_.chomp}\nNo title_en." if @flog
            else
              article[:title_en] = str.strip
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 20: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "h"
  ##################summary_rus
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              @flog.puts_utf16 "main_read. 21: Error in line #{$.}: #{$_.chomp}\nNo summary_rus." if @flog
            else
              article[:summary_rus] = str.strip
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 22: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_
        end
      elsif $1 == "i"
  ##################summary_en
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              @flog.puts_utf16 "main_read. 23: Error in line #{$.}: #{$_.chomp}\nNo summary_en." if @flog
            else
              article[:summary_en] = str.strip
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 24: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_
        end
      elsif $1 == "j"
  ##################keywords_rus
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              @flog.puts_utf16 "main_read. 25: Error in line #{$.}: #{$_.chomp}\nNo keywords_rus." if @flog
            else
              article[:keywords_rus] = str.strip.split(/[,;]/).map!{|i| i.gsub(".","")}.find_all{|i| i.size > 0}
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 26: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "k"
  ##################keywords_en
        str = ""
        while @fin.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              @flog.puts_utf16 "main_read. 27: Error in line #{$.}: #{$_.chomp}\nNo keywords_en." if @flog
            else
              article[:keywords_en] = str.strip.split(/[,;]/).map!{|i| i.gsub(".","")}.find_all{|i| i.size > 0}
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "main_read. 28: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "l"
  ##################lists
        str = ""
        article[:lists] = []
        while @fin.gets
  #here may be smth like choosing true lists from some number of strings
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if article[:lists].size < 1
              @flog.puts_utf16 "main_read. 29: Error in line #{$.}: #{$_chomp}\nNo list." if @flog
            end
            break 
          end
          if $_.strip != ""
            article[:lists] << $_.strip
          end
        end
      end
    elsif $_.strip == ""
      @fin.gets
      next
    else
      $stderr.puts "main_read. 31: Error in line #{$.}: #{$_.chomp}"
      @fin.gets
    end
  end
  return articles
end
