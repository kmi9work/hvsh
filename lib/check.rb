
def check (articles, number_name)
  nkeys = 0
  empty = 0
  articles.each_with_index do |article,index|  
    article.each do |key, cont|
      empty += 1 if cont.nil? or cont.empty?
      if key == :authors
        article[:authors].each do |author|
          author.each do |key, cont|
            empty += 1 if cont.nil? or cont.empty?
            nkeys += 1
          end
        end
      else
        nkeys += 1
      end
    end
    if article[:pages].nil? or article[:pages].empty?
      $stderr.puts "FATAL!!! No pages. in #{index}."
    end
    if article[:type].nil? or article[:type].empty?
      $stderr.puts "FATAL!!! No type. in #{index}."
    end
    if article[:title_rus].nil? or article[:title_rus].empty?
      $stderr.puts "FATAL!!! No title_rus. in #{index}."
    end
    if article[:title_en].nil? or article[:title_en].empty?
      $stderr.puts "FATAL!!! No title_en. in #{index}."
    end
    #en_rus
    if (article[:section_en].nil? or article[:section_en].empty?) and !(article[:section_rus].nil? or article[:section_rus].empty?)
      $stderr.puts "FATAL!!! No section_en, but there is section_rus. in #{index}."
    end
    if !(article[:section_en].nil? or article[:section_en].empty?) and (article[:section_rus].nil? or article[:section_rus].empty?)
      $stderr.puts "FATAL!!! No section_rus, but there is section_en. in #{index}."
    end
    
    if (article[:title_en].nil? or article[:title_en].empty?) and !(article[:title_rus].nil? or article[:title_rus].empty?)
      $stderr.puts "FATAL!!! No title_en, but there is title_rus. in #{index}."
    end
    if !(article[:title_en].nil? or article[:title_en].empty?) and (article[:title_rus].nil? or article[:title_rus].empty?)
      $stderr.puts "FATAL!!! No title_rus, but there is title_en. in #{index}."
    end
    
    if (article[:summary_en].nil? or article[:summary_en].empty?) and !(article[:summary_rus].nil? or article[:summary_rus].empty?)
      $stderr.puts "FATAL!!! No summary_en, but there is summary_rus. in #{index}."
    end
    if !(article[:summary_en].nil? or article[:summary_en].empty?) and (article[:summary_rus].nil? or article[:summary_rus].empty?)
      $stderr.puts "FATAL!!! No summary_rus, but there is summary_en. in #{index}."
    end
    
    if (article[:keywords_en].nil? or article[:keywords_en].empty?) and !(article[:keywords_rus].nil? or article[:keywords_rus].empty?)
      $stderr.puts "FATAL!!! No keywords_en, but there is keywords_rus. in #{index}."
    end
    if !(article[:keywords_en].nil? or article[:keywords_en].empty?) and (article[:keywords_rus].nil? or article[:keywords_rus].empty?)
      $stderr.puts "FATAL!!! No keywords_rus, but there is keywords_en. in #{index}."
    end
    
    
    
    unless article[:authors].nil? or article[:authors].empty?
      article[:authors].each_with_index do |author, i|
        if author[:name_en].nil? or author[:name_en].empty? 
          $stderr.puts "FATAL!!! No name_en in authors(#{i}). in #{index}."
        else
          unless author[:name_en] =~ /(..?\. ?..?\..*\,? ? ?)+/ or author[:name_en] =~ /(.*..?\. ?..?\.,? ? ?)+/
            unless author[:name_en] =~ /(.\.)(.*)/ or author[:name_en] =~ /(.*)(.\.)/
              $stderr.puts "FATAL!!! Wrong name_en in authors(#{i}). in #{index}. name: #{author[:name_en]}"
            else
              $stderr.puts "Strange name_en in authors(#{i}). in #{index}. name: #{author[:name_en]}"
            end
          end
        end
        if author[:name_rus].nil? or author[:name_rus].empty?
          $stderr.puts "FATAL!!! No name_rus in authors(#{i}). in #{index}."
        else
          unless author[:name_rus] =~ /(..?\. ?..?\..*\,? ? ?)+/ or author[:name_rus] =~ /(.*..?\. ?..?\.,? ? ?)+/
            unless author[:name_rus] =~ /(.\.)(.*)/ or author[:name_rus] =~ /(.*)(.\.)/
              $stderr.puts "FATAL!!! Wrong name_rus in authors(#{i}). in #{index}. name: #{author[:name_rus]}"
            else 
              $stderr.puts "Strange name_rus in authors(#{i}). in #{index}. name: #{author[:name_rus]}"
            end
          end
        end

        if (author[:adress_en].nil? or author[:adress_en].empty?) and !(author[:adress_rus].nil? or author[:adress_rus].empty?)
          $stderr.puts "FATAL!!! No adress_en, but there is adress_rus. in authors(#{i}) in #{index}."
        end
        if !(author[:adress_en].nil? or author[:adress_en].empty?) and (author[:adress_rus].nil? or author[:adress_rus].empty?)
          $stderr.puts "FATAL!!! No adress_rus, but there is adress_en. in authors(#{i}) in #{index}."
        end

        if (author[:workplace_en].nil? or author[:workplace_en].empty?) and !(author[:workplace_rus].nil? or author[:workplace_rus].empty?)
          $stderr.puts "FATAL!!! No workplace_en, but there is workplace_rus. in authors(#{i}) in #{index}: #{author[:workplace_rus]}"
          
        end
        if !(author[:workplace_en].nil? or author[:workplace_en].empty?) and (author[:workplace_rus].nil? or author[:workplace_rus].empty?)
          $stderr.puts "FATAL!!! No workplace_rus, but there is workplace_en. in authors(#{i}) in #{index}: #{author[:workplace_en]}."
        end  
      end
    else
      $stderr.puts "FATAL!!! No authors. in #{index}."
    end
    
    
    #=en_rus
  end
  stat = File.new("statistics.txt", "r")
  buf = stat.readlines
  stat.close
  yaml = [{}]
  j = 0
  buf.each do |b|
    unless b =~ /(.+):(.+)/
      unless b.strip.empty?
        puts "error in statistics.txt" 
        puts b
      else
        yaml << {}
        j += 1
      end
    else
      yaml[j][$1.strip.to_sym] = $2.strip  
    end 
  end 
  unless yaml.select{|i| i[:name] == number_name.strip}.size > 0
    stat = File.new("statistics.txt", "w+")
    stat.puts buf
    stat.puts "name: #{number_name}"
    stat.puts "date: #{Time.now}"
    stat.puts "nkeys: #{nkeys}"
    stat.puts "empty: #{empty}"
    stat.puts "e_k: #{empty.to_f / nkeys.to_f}"
    stat.puts
    stat.close
  end
end




