# -*- coding: utf-8 -*-
 def mfe (articles)
  articles.each_index do |i|
    @fout.puts_utf16 "_#{i}."
    articles[i].each do |cat, cont|
      case cat
      when :summary_rus
        if cont == nil or cont == ""
          if articles[i][:summary_en] != nil and articles[i][:summary_en] != ""
            @fout.puts_utf16 "h) Аннотация:"
            @fout.puts_utf16 ""
            @fout.puts_utf16 ""
            @fout.puts_utf16 "i) Summary:"
            @fout.puts_utf16 articles[i][:summary_en]
            @fout.puts_utf16 ""
          end
        end
      when :section_en
        if cont == nil or cont == ""
          if articles[i][:section_rus] != nil and articles[i][:section_rus] != ""
            @fout.puts_utf16 "a) Раздел:"
            @fout.puts_utf16 articles[i][:section_rus]
            @fout.puts_utf16 ""
            @fout.puts_utf16 "b) Section:"
            @fout.puts_utf16 ""
            @fout.puts_utf16 ""
          end
        end
      when :authors
        is_first = 1
        if articles[i][:authors] == nil
          p articles[0][:authors]
          p articles[i] 
          p i
        end  
        k = 0
        articles[i][:authors].each do |author|
          author.each do |a, b|
            case a
            when :name_en
              if b == nil or b == ""
                if author[:name_rus] != nil and author[:name_rus] != ""
                  if is_first == 1
                    is_first = 0
                    @fout.puts_utf16 "e) Автор(ы)/Author(s):"
                    @fout.puts_utf16 ""
                  end
                  @fout.puts_utf16 "-a#{k} ФИО:"
                  @fout.puts_utf16 author[:name_rus]
                  @fout.puts_utf16 ""
                  @fout.puts_utf16 "-b#{k} Name:"
                  @fout.puts_utf16 ""
                  @fout.puts_utf16 ""
                end
              end
            when :adress_en
              if b == nil or b == ""
                if author[:adress_rus] != nil and author[:adress_rus] != ""
                  if is_first == 1
                    is_first = 0
                    @fout.puts_utf16 "e) Автор(ы)/Author(s):"
                    @fout.puts_utf16 ""
                  end
                  @fout.puts_utf16 "-c#{k} Адрес(город):"
                  @fout.puts_utf16 author[:adress_rus]
                  @fout.puts_utf16 ""
                  @fout.puts_utf16 "-d#{k} Adress(City):"
                  @fout.puts_utf16 ""
                  @fout.puts_utf16 ""
                end
              end
            when :workplace_en    
              if b == nil or b == ""
                if author[:workplace_rus] != nil and author[:workplace_rus] != ""
                  if is_first == 1
                    is_first = 0
                    @fout.puts_utf16 "e) Автор(ы)/Author(s):"
                    @fout.puts_utf16 ""
                  end
                  @fout.puts_utf16 "-e#{k} Место работы:"
                  @fout.puts_utf16 author[:workplace_rus]
                  @fout.puts_utf16 ""
                  @fout.puts_utf16 "-f#{k} Work place:"
                  @fout.puts_utf16 ""
                  @fout.puts_utf16 ""
                end
              end
            end
          end
          k += 1
        end
      when :title_en
        if cont == nil or cont == ""
          if articles[i][:title_rus] != nil and articles[i][:title_rus] != ""
            @fout.puts_utf16 "f) Название статьи:"
            @fout.puts_utf16 articles[i][:title_rus]
            @fout.puts_utf16 ""
            @fout.puts_utf16 "g) title:"
            @fout.puts_utf16 ""
            @fout.puts_utf16 ""
          end
        end
      when :summary_en
        if cont == nil or cont == ""
          if articles[i][:summary_rus] != nil and articles[i][:summary_rus] != ""
            @fout.puts_utf16 "h) Аннотация:"
            @fout.puts_utf16 articles[i][:summary_rus]
            @fout.puts_utf16 ""
            @fout.puts_utf16 "i) Summary:"
            @fout.puts_utf16 ""
            @fout.puts_utf16 ""
          end
        end
      when :keywords_en
        if cont == nil or cont == []
          if articles[i][:keywords_rus] != nil and articles[i][:keywords_rus] != []
            @fout.puts_utf16 "j) Ключевые слова:"
            j = 0
            for j in 0...articles[i][:keywords_rus].size - 1
              @fout.print_utf16_utf16 "#{articles[i][:keywords_rus][j]}, "
            end
            @fout.print_utf16 "#{articles[i][:keywords_rus][-1]}.\n"
            @fout.puts_utf16 ""
            @fout.puts_utf16 "k) Key words:"
            @fout.puts_utf16 ""
            @fout.puts_utf16 ""
          end
        end
      when  :section_rus, :pages, :type, :title_rus, :summary_rus, :keywords_rus, :lists
        next
      else
        $stderr.puts "mfe: Error in articles: #{cat}"
      end
    end
    @fout.puts_utf16 "-"
  end
end
