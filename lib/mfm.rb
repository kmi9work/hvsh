# -*- coding: utf-8 -*-
#article -- :section_rus, :section_en, :pages, :type, :authors, :title_rus, :title_en, 
#           :summary_rus, :summary_en, :keywords_rus, :keywords_en, :lists
ARTICLE_SYM = [:section_rus, :section_en, :authors, :title_rus, :title_en, :summary_rus, :summary_en, :keywords_rus, :keywords_en]

def mfm (articles)
  articles.each_index do |i|
    @fout.puts_utf16 "_#{i}."
    ARTICLE_SYM.each do |cat|
      cont = articles[i][cat]
      case cat
      when :section_rus
        if cont != nil and cont != ""
          @fout.puts_utf16 "a) Раздел:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      when :section_en
        if cont != nil and cont != ""
          @fout.puts_utf16 "b) Section:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      when :authors
        @fout.puts_utf16 "e) Автор(ы)/Author(s):"
        @fout.puts_utf16
        articles[i][:authors].each do |author|
          AUTHOR_SYM.each do |a|
            b = author[a]
            case a
            when :name_rus
              if b != nil and b != ""
                @fout.puts_utf16 "-a ФИО:"
                @fout.puts_utf16 b
                @fout.puts_utf16
              end
            when :name_en
              if b != nil and b != ""
                @fout.puts_utf16 "-b Name:"
                @fout.puts_utf16 b
                @fout.puts_utf16
              end
            when :adress_rus
              if b != nil and b != ""
                @fout.puts_utf16 "-c Адрес(город):"
                @fout.puts_utf16 b
                @fout.puts_utf16
              end
            when :adress_en
              if b != nil and b != ""
                @fout.puts_utf16 "-d Adress(City):"
                @fout.puts_utf16 b
                @fout.puts_utf16
              end
            when :workplace_rus
              if b != nil and b != ""
                @fout.puts_utf16 "-e Место работы:"
                @fout.puts_utf16 b
                @fout.puts_utf16
              end
            when :workplace_en    
              if b != nil and b != ""
                @fout.puts_utf16 "-f Work place:"
                @fout.puts_utf16 b
                @fout.puts_utf16
              end
            end
          end
        end
      when :title_rus
        if cont != nil and cont != ""
          @fout.puts_utf16 "f) Название статьи:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      when :title_en
        if cont != nil and cont != ""
          @fout.puts_utf16 "g) title:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      when :summary_rus
        if cont != nil and cont != ""
          @fout.puts_utf16 "h) Аннотация:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      when :summary_en
        if cont != nil and cont != ""
          @fout.puts_utf16 "i) Summary:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      when :keywords_rus
        if cont != nil and cont != ""
          @fout.puts_utf16 "j) Ключевые слова:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      when :keywords_en
        if cont != nil and cont != ""
          @fout.puts_utf16 "k) Key words:"
          @fout.puts_utf16 cont
          @fout.puts_utf16
        end
      end
    end
    @fout.puts_utf16 "-"
  end
end
