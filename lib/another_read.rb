def another_read (articles)
  str = ""
  nstr = 0
  index = -1
  @fsecond.gets
  while true
    str = ""
    break if $_ == nil
    if $_.strip =~ /_(\d\d?)\./
      index = $1.to_i
      article = articles[index]
      @fsecond.gets
      next
    end
    if $_ =~ /(^[a-l])\).*?:/
      if $1 == "b"
##################section_en
        str = ""
        while @fsecond.gets
          if $_ =~ /^[a-l]\)/
            if str.size < 1
              $stderr.puts "another_read. 4: Error in line #{$.}: #{$_.chomp}\nNo section_en."
              break
            end
            if article[:section_en] == nil or article[:section_en] == ""
              article[:section_en] = str.strip
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "another_read. 5: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "e"
  ##################author
        author_index = 0
        str = ""
        nstr = 0
        @fsecond.gets
        while true
          if $_ =~ /^(-[a-f])(\d)/
            case $1
            when "-a"
              nstr = 0
            when "-b"
              nstr = 1
            when "-c"
              nstr = 2
            when "-d"
              nstr = 3
            when "-e"
              nstr = 4
            when "-f"
              nstr = 5
            else
              $stderr.puts "6: Error in authors: Wrong beginning. #{$.}"
            end
            author_index = $2.to_i
            while @fsecond.gets
              if $_ =~ /^[a-l]\)/ or $_ =~ /^-/
                if str.strip.size < 1
                  $stderr.puts "another_read. 14: Error in line #{$.}: #{$_.chomp}\nNo author #{nstr}."
                else
                  p $. if article[:authors][author_index] == nil
                  if article[:authors][author_index][AUTHOR_SYM[nstr]] == nil or article[:authors][author_index][AUTHOR_SYM[nstr]] == ""
                    article[:authors][author_index][AUTHOR_SYM[nstr]] = str.strip
                  else
                    # article[:authors].each do |aa|
                    #                       if aa[AUTHOR_SYM[nstr]] == nil or aa[AUTHOR_SYM[nstr]] == ""
                    #                         aa[AUTHOR_SYM[nstr]] = str.strip #ERROR
                    #                       end
                    #                     end  
                  end  
                  str = ""
                end
                break
              end
              str += $_.chomp
            end
          elsif $_ =~ /^[a-l]\)/ or $_.strip == "-"
            #if nstr != 5
            #  $stderr.puts "another_read. 16: Error in line #{$.}: #{$_.chomp}\nWrong number of Author: #{nstr}."
            #end
            break
          else
            @fsecond.gets
          end
        end 
      elsif $1 == "g"
  ##################title_en
        str = ""
        while @fsecond.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              $stderr.puts "another_read. 19: Error in line #{$.}: #{$_.chomp}\nNo title_en."
            else
              if article[:title_en] == nil or article[:title_en] == ""
                article[:title_en] = str.strip
              end
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "another_read. 20: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      elsif $1 == "h"
        str = ""
        while @fsecond.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              $stderr.puts "another_read. 23: Error in line #{$.}: #{$_.chomp}\nNo summary_rus."
            else
              if article[:summary_rus] == nil or article[:summary_rus] == ""
                article[:summary_rus] = str.strip
              end
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "another_read. 24: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_
        end
      elsif $1 == "i"
  ##################summary_en
        str = ""
        while @fsecond.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              $stderr.puts "another_read. 23: Error in line #{$.}: #{$_.chomp}\nNo summary_en."
            else
              if article[:summary_en] == nil or article[:summary_en] == ""
                article[:summary_en] = str.strip
              end
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "another_read. 24: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_
        end
      elsif $1 == "k"
  ##################keywords_en
        str = ""
        while @fsecond.gets
          if $_ =~ /^[a-l]\)/ or $_.strip == "-"
            if str.size < 1
              $stderr.puts "another_read. 27: Error in line #{$.}: #{$_.chomp}\nNo keywords_en."
            else
              if article[:keywords_en] == nil or article[:keywords_en] == []
                article[:keywords_en] = str.strip.split(/[,;\.]/).map{|i| i.strip}.find_all{|i| i.size > 0}
              end
            end
            break 
          end
          if $_ =~ /^-/
            $stderr.puts "another_read. 28: Error in line #{$.}: #{$_.chomp}"
            break
          end
          str += $_.chomp
        end
      else
        @fsecond.gets
        next
      end
    elsif $_.strip == ""
      @fsecond.gets
      next
    else
      @fsecond.gets
      next
    end
  end
  return articles
end