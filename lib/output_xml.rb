# -*- coding: utf-8 -*-

#author = Struct.new(:name_rus, :name_en, :adress_rus, :adress_en, :workplace_rus, :workplace_en)
#article -- :section_rus, :section_en, :pages, :type, :authors, :title_rus, :title_en, 
#           :summary_rus, :summary_en, :keywords_rus, :keywords_en, :lists

def output_xml (articles)
  @fxml.puts_utf16 '<?xml version="1.0" standalone="no" ?>'
  @fxml.puts_utf16 '<journals>'
  @fxml.puts_utf16 '  <opercard>'
  @fxml.puts_utf16 '    <operator>ХвШ|Костенчук М. И.</operator>'
  t = Time.new
  @fxml.puts_utf16 "    <date>#{t.strftime("%Y-%m-%d_%H:%M:%S")}</date>"
  cntnode = 0
  cs = 0
  #  articles.each do |article|
  #    article.each do |cat, cont|
  # РАЗДЕЛЫ !!!      РАЗДЕЛЫ !!!      РАЗДЕЛЫ !!!      
  #    end
  #  end
  @fxml.puts_utf16 '  </opercard>'
  @fxml.puts_utf16 '  <journal>'
  @fxml.puts_utf16 '    <journalInfo lang="RUS">'
  @fxml.puts_utf16 '      <jrntitle>Химия в школе</jrntitle>'
  @fxml.puts_utf16 '      <publ>ООО "Центрхимпресс"</publ>'
  @fxml.puts_utf16 '      <placepubl>Москва</placepubl>'
  @fxml.puts_utf16 '      <loc>Москва, ул. П. Корчагина, д. 7</loc>'
  @fxml.puts_utf16 '    </journalInfo>'
  @fxml.puts_utf16 '    <issue>'
  @fxml.puts_utf16 '      <issn>0368-5632</issn>'
  @fxml.puts_utf16 '      <jrncode>03685632</jrncode>'
  print "Input journal number, please(dd): "
  n = $stdin.gets.strip
  @fxml.puts_utf16 "      <jnumUni>#{n}</jnumUni>"
  print "Input year and month of journal (yearmonth), please: "
  n = $stdin.gets.strip
  @fxml.puts_utf16 "      <jdateUni>#{n}</jdateUni>"
  @fxml.puts_utf16 "      <pages>1-#{articles[-1][:pages][-1]}</pages>"
  articles.each do |article|
    if article[:section_rus] != nil and article[:section_rus] != "" or article[:section_en] != nil and article[:section_en] != ""
      @fxml.puts_utf16'        <jseparate>'
      if article[:section_rus] != nil and article[:section_rus] != ""
        @fxml.puts_utf16"          <segtitle lang=\"RUS\">#{article[:section_rus]}</segtitle>"
      end
      if article[:section_en] != nil and article[:section_en] != ""
        @fxml.puts_utf16"          <segtitle lang=\"ENG\">#{article[:section_en]}</segtitle>"
      end
      @fxml.puts_utf16'        </jseparate>'
    end
    @fxml.puts_utf16 '        <article>'
    @fxml.puts_utf16 "          <fpageart>#{article[:pages][0]}</fpageart>"
    @fxml.puts_utf16 "          <lpageart>#{article[:pages][1]}</lpageart>"
    fl = 0
    article[:authors].each do |author|
      author.each do |key,a|
        fl = 1 if a != nil and a != ""
        break
      end
      break if fl == 1
    end
    if fl == 1
      @fxml.puts_utf16 '          <authors>'
      index = 1
      if article[:authors] != nil and article[:authors] != [] and article[:authors] != ""
        article[:authors].each do |author|
          arr_rus = [author[:name_rus]]
          arr_en = [author[:name_en]]
          if author[:name_rus] =~ /(..?\. ?..?\..*\,? ? ?){2,}/ or author[:name_rus] =~ /(.*..?\. ?..?\.,? ? ?){2,}/
            arr_rus = author[:name_rus].split(/[,;]/).map{|i| i.strip}.find_all{|i| i.size > 0}
            if author[:name_en] =~ /(..?\. ?..?\..*\,? ? ?){2,}/ or author[:name_en] =~ /(.*..?\. ?..?\.,? ? ?){2,}/
              arr_en = author[:name_en].split(/[,;]/).map{|i| i.strip}.find_all{|i| i.size > 0}
            else
              $stderr.puts "1:FATAL ERROR IN AUTHORS!!! English not same as russian:\nRUS: #{author[:name_rus]}\nENG: #{author[:name_en]}"
            end
          end
          if arr_rus.size != arr_en.size
            $stderr.puts "2:FATAL ERROR IN AUTHORS!!! English not same as russian:\nRUS: #{author[:name_rus]}\nENG: #{author[:name_en]}"
          end
          for i in 0...arr_rus.size
            rus = arr_rus[i]
            eng = arr_en[i]
            @fxml.puts_utf16 "            <author num=\"#{index}\">"
            @fxml.puts_utf16 "              <correspondent>0</correspondent>" #mb change correspondent
            #RUS
            @fxml.puts_utf16 "              <individInfo lang=\"RUS\">"
            fname = ""
            surname = ""
            if rus =~ /(.\. ?.\.)(.*)/
              fname = $1.strip
              surname = $2.strip
            elsif rus =~ /(.*)(.\. ?.\.)/
              fname = $2.strip
              surname = $1.strip
            else
              $stderr.puts "4:FATAL ERROR IN AUTHORS!!! #{rus}"
              p article
            end
            @fxml.puts_utf16 "                <surname>#{surname}</surname>"
            @fxml.puts_utf16 "                <fname>#{fname}</fname>"
            if author[:adress_rus] != nil and author[:adress_rus] != "" 
              @fxml.puts_utf16 "                <auadr>#{author[:adress_rus]}</auadr>"
            end
            if author[:workplace_rus] != nil and author[:workplace_rus] != "" 
              @fxml.puts_utf16 "                <auwork>#{author[:workplace_rus]}</auwork>"
            end
            @fxml.puts_utf16 "              </individInfo>"
            # ENG
            @fxml.puts_utf16 "              <individInfo lang=\"ENG\">"
            fname = ""
            surname = ""
            if eng =~ /(..?\. ?..?\.)(.+)/
              fname = $1.strip
              surname = $2.strip
            elsif eng =~ /(.+)(..?\. ?..?\.)/
              fname = $2.strip
              surname = $1.strip
            else
              $stderr.puts "#{$.} - 3:FATAL ERROR IN AUTHORS!!! #{eng.inspect}"
            end
            @fxml.puts_utf16 "                <surname>#{surname}</surname>"
            @fxml.puts_utf16 "                <fname>#{fname}</fname>"
            if author[:adress_en] != nil and author[:adress_en] != "" 
              @fxml.puts_utf16 "                <auadr>#{author[:adress_en]}</auadr>"
            end
            if author[:workplace_en] != nil and author[:workplace_en] != "" 
              @fxml.puts_utf16 "                <auwork>#{author[:workplace_en]}</auwork>"
            end
            @fxml.puts_utf16 "              </individInfo>"
            @fxml.puts_utf16 "            </author>"
            index += 1
          end
        end
        @fxml.puts_utf16 '          </authors>'
      else
        $stderr.puts '135:Error in authors.'
      end
    else
      @fxml.puts_utf16 '          <noauthors />'
    end
    @fxml.puts_utf16 '          <arttitles>'
    if article[:title_rus] != nil and article[:title_rus] != "" and article[:title_en] != nil and article[:title_en] != ""
      @fxml.puts_utf16 "            <arttitle lang=\"RUS\">#{article[:title_rus]}</arttitle>"
      @fxml.puts_utf16 "            <arttitle lang=\"ENG\">#{article[:title_en]}</arttitle>"
    else
      $stderr.puts "#{$.}Fatal Error! No title."
    end
    @fxml.puts_utf16 '          </arttitles>'

    if article[:summary_rus] != nil and article[:summary_rus] != "" and article[:summary_en] != nil and article[:summary_en] != ""
      @fxml.puts_utf16 '          <abstracts>'
      @fxml.puts_utf16 "            <abstract lang=\"RUS\">#{article[:summary_rus]}</abstract>"
      @fxml.puts_utf16 "            <abstract lang=\"ENG\">#{article[:summary_en]}</abstract>"
      @fxml.puts_utf16 '          </abstracts>'
    else
      @fxml.puts_utf16 '          <noabstracts />'
      $stderr.puts "#{$.}Fatal Error! No summary."
    end

    if article[:type] != nil and article[:type] != ""
      @fxml.puts_utf16 "          <arttype>#{article[:type]}</arttype>"
    else
      @fxml.puts_utf16 "          <arttype />"
      $stderr.puts "#{$.}Fatal Error! No type."
    end
    @fxml.print_utf16 "          <text lang=\"RUS\" arttype=\"#{article[:type]}\">"
    @fxml.puts_utf16 article[:title_rus]
    @fxml.puts_utf16 ""
    @fxml.puts_utf16 "           #{article[:summary_rus]}"
    @fxml.puts_utf16 ""
    @fxml.puts_utf16 '          </text>'
    if article[:keywords_rus] == nil or article[:keywords_rus] == [] and article[:keywords_en] == nil or article[:keywords_en] == []
      @fxml.puts_utf16 '          <nokeywords />'
    else
      @fxml.puts_utf16 '          <keywords>'
      if article[:keywords_rus] != nil and article[:keywords_rus] != []
        @fxml.puts_utf16 '            <kwdGroup lang="RUS">'
        article[:keywords_rus].each do |keyword|
          @fxml.puts_utf16 "              <keyword>#{keyword}</keyword>"
        end
        @fxml.puts_utf16 '            </kwdGroup>'
      end
      if article[:keywords_en] != nil and article[:keywords_en] != []
        @fxml.puts_utf16 '            <kwdGroup lang="ENG">'
        article[:keywords_en].each do |keyword|
          @fxml.puts_utf16 "              <keyword>#{keyword}</keyword>"
        end
        @fxml.puts_utf16 '            </kwdGroup>'
      end
      @fxml.puts_utf16 '          </keywords>'
    end
    if article[:lists] != nil and article[:lists] != [] and article[:lists] != ""
      @fxml.puts_utf16 '          <biblist>'
      article[:lists].each do |list| 
        while list =~ /"(.*?)"/
          puts "Original list: #{list}"
          list.sub!(/"(.*?)"/,"&lt;#{$1}&gt;")
          puts "Changed list: #{list}\nMust be true &lt,&gt"
        end
        @fxml.print_utf16 '            <blistpart>'
        @fxml.puts_utf16 list
        @fxml.puts_utf16 ""
        @fxml.puts_utf16 '            </blistpart>'
      end
      @fxml.puts_utf16 '          </biblist>'
    else  
      @fxml.puts_utf16 '          <nobiblist />'#!!!!!
    end
    @fxml.puts_utf16 '        </article>'
  end
  @fxml.puts_utf16 '    </issue>'
  @fxml.puts_utf16 '  </journal>'
  @fxml.puts_utf16 '</journals>'
end
