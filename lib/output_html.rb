# -*- coding: utf-8 -*-
require 'erb'

def output_html(articles)
  rus_erb = File.new('lib/rus_php.html.erb').readlines.join
  eng_erb = File.new('lib/eng_php.html.erb').readlines.join
  template_rus = ERB.new(rus_erb)
  template_eng = ERB.new(eng_erb)
  rus_result = ''
  eng_result = ''
  articles.each do |article|
    @article = article
    rus_result += template_rus.result.gsub(/\n\s*\n/, "\n")
    eng_result += template_eng.result.gsub(/\n\s*\n/, "\n")
  end  
  @fhtml_rus.puts rus_result
  @fhtml_eng.puts eng_result
    
    # if article[:section_rus] != nil and article[:section_rus] != "" or article[:section_en] != nil and article[:section_en] != ""
    #       if article[:section_rus] != nil and article[:section_rus] != ""
    #         @fhtml_rus.puts_utf16 "<h2>#{article[:section_rus]}</h2>"
    #       end
    #       if article[:section_en] != nil and article[:section_en] != ""
    #         @fhtml_eng.puts_utf16 "<h2>#{article[:section_en]}</h2>"
    #       end
    #     end
    
    # if article[:title_rus] != nil and article[:title_rus] != "" and article[:title_en] != nil and article[:title_en] != ""
    #       @fhtml_rus.puts_utf16 "<h3>#{article[:title_rus]}</h3>"
    #       @fhtml_eng.puts_utf16 "<h3>#{article[:title_en]}</h3>"
    #     else
    #       $stderr.puts "#{index}Fatal Error! No title."
    #       p article
    #     end
    
    # fl = 0
    #     article[:authors].each do |author|
    #       author.each do |key,a|
    #         fl = 1 if a != nil and a != ""
    #         break
    #       end
    #       break if fl == 1
    #     end
    #     if fl == 1
    #       @fhtml_rus.puts_utf16 '<div class="paragraph"><div class="title">Авторы:</div>'
    #       @fhtml_eng.puts_utf16 '<div class="paragraph"><div class="title">Authors:</div>'
    #       index = 1
    #       if article[:authors] != nil and article[:authors] != [] and article[:authors] != ""
    #         article[:authors].each do |author|
    #           arr_rus = [author[:name_rus]]
    #           arr_en = [author[:name_en]]
    #           if author[:name_rus] =~ /(..?\. ?..?\..*\,? ? ?){2,}/ or author[:name_rus] =~ /(.*..?\. ?..?\.,? ? ?){2,}/
    #             arr_rus = author[:name_rus].split(/[,;]/).map{|i| i.strip}.find_all{|i| i.size > 0}
    #             if author[:name_en] =~ /(..?\. ?..?\..*\,? ? ?){2,}/ or author[:name_en] =~ /(.*..?\. ?..?\.,? ? ?){2,}/
    #               arr_en = author[:name_en].split(/[,;]/).map{|i| i.strip}.find_all{|i| i.size > 0}
    #             else
    #               $stderr.puts "1:FATAL ERROR IN AUTHORS!!! English not same as russian:\nRUS: #{author[:name_rus]}\nENG: #{author[:name_en]}"
    #             end
    #           end
    #           if arr_rus.size != arr_en.size
    #             $stderr.puts "2:FATAL ERROR IN AUTHORS!!! English not same as russian:\nRUS: #{author[:name_rus]}\nENG: #{author[:name_en]}"
    #           end
    #           for i in 0...arr_rus.size
    #             rus = arr_rus[i]
    #             eng = arr_en[i]
    #             @fhtml_rus.puts_utf16 "<p>"
    #             @fhtml_eng.puts_utf16 "<p>"
    #             #RUS
    #             fname = ""
    #             surname = ""
    #             if rus =~ /(.\. ?.\.)(.*)/
    #               fname = $1.strip
    #               surname = $2.strip
    #             elsif rus =~ /(.*)(.\. ?.\.)/
    #               fname = $2.strip
    #               surname = $1.strip
    #             else
    #               $stderr.puts "4:FATAL ERROR IN AUTHORS!!! #{rus.inspect}"
    #             end
    #             @fhtml_rus.print_utf16 "<b>#{surname} #{fname}</b>. "
    #             if author[:adress_rus] != nil and author[:adress_rus] != "" 
    #               @fhtml_rus.print_utf16 "Адрес: #{author[:adress_rus]}. "
    #             end
    #             if author[:workplace_rus] != nil and author[:workplace_rus] != "" 
    #               @fhtml_rus.print_utf16 "Место работы: #{author[:workplace_rus]}."
    #             end
    #             @fhtml_rus.puts_utf16 ""
    #             # ENG
    #             fname = ""
    #             surname = ""
    #             if eng =~ /(..?\. ?..?\.)(.+)/
    #               fname = $1.strip
    #               surname = $2.strip
    #             elsif eng =~ /(.+)(..?\. ?..?\.)/
    #               fname = $2.strip
    #               surname = $1.strip
    #             else
    #               $stderr.puts "#{index} - 3:FATAL ERROR IN AUTHORS!!! #{eng.inspect}"
    #             end
    #             @fhtml_eng.print_utf16 "<b>#{surname} #{fname}</b>. "
    #             if author[:adress_en] != nil and author[:adress_en] != "" 
    #               @fhtml_eng.print_utf16 "Adress: #{author[:adress_en]}. "
    #             end
    #             if author[:workplace_en] != nil and author[:workplace_en] != "" 
    #               @fhtml_eng.print_utf16 "Workplace: #{author[:workplace_en]}."
    #             end
    #             @fhtml_eng.puts_utf16 ""
    #             @fhtml_rus.puts_utf16 "</p>"
    #             @fhtml_eng.puts_utf16 "</p>"
    #             index += 1
    #           end
    #         end
    #         @fhtml_rus.puts_utf16 '</div>'
    #         @fhtml_eng.puts_utf16 '</div>'
    #       else
    #         $stderr.puts '135:Error in authors.'
    #       end
    #       
    #     end
    #     
    #     if article[:summary_rus] != nil and article[:summary_rus] != "" and article[:summary_en] != nil and article[:summary_en] != ""
    #       @fhtml_rus.puts_utf16 '<div class="exampleblock">'
    #       @fhtml_eng.puts_utf16 '<div class="exampleblock">'
    #       @fhtml_rus.puts_utf16 '<div class="title">Аннотация</div>'
    #       @fhtml_eng.puts_utf16 '<div class="title">Summary</div>'
    #       @fhtml_rus.puts_utf16 '<div class="exampleblock-content">'
    #       @fhtml_eng.puts_utf16 '<div class="exampleblock-content">'
    #       @fhtml_rus.puts_utf16 '<div class="paragraph"><p>'
    #       @fhtml_eng.puts_utf16 '<div class="paragraph"><p>'
    #       @fhtml_rus.puts_utf16 "#{article[:summary_rus]}"
    #       @fhtml_eng.puts_utf16 "#{article[:summary_en]}"
    #       @fhtml_rus.puts_utf16 '</p></div>'
    #       @fhtml_eng.puts_utf16 '</p></div>'
    #       @fhtml_rus.puts_utf16 '</div>'
    #       @fhtml_eng.puts_utf16 '</div>'
    #       @fhtml_rus.puts_utf16 '</div>'
    #       @fhtml_eng.puts_utf16 '</div>'
    #     else
    #       $stderr.puts "#{index}Fatal Error! No summary."
    #       p article
    #     end
    #     
    # 
    #     unless article[:keywords_rus] == nil or article[:keywords_rus] == [] and article[:keywords_en] == nil or article[:keywords_en] == []
    #       @fhtml_rus.puts_utf16 '<div class="paragraph">'
    #       @fhtml_eng.puts_utf16 '<div class="paragraph">'
    #       @fhtml_rus.puts_utf16 '<div class="title">Ключевые слова: </div>'
    #       @fhtml_eng.puts_utf16 '<div class="title">Keywords: </div>'
    #       if article[:keywords_rus] != nil and article[:keywords_rus] != []
    #         @fhtml_rus.puts_utf16 '<p>'
    #         article[:keywords_rus][0].capitalize!
    #         @fhtml_rus.print_utf16 article[:keywords_rus]*", "
    #         @fhtml_rus.puts_utf16 "."
    #         @fhtml_rus.puts_utf16 '</p>'
    #       end
    #       if article[:keywords_en] != nil and article[:keywords_en] != []
    #         @fhtml_eng.puts_utf16 '<p>'
    #         article[:keywords_en][0].capitalize!
    #         @fhtml_eng.print_utf16 article[:keywords_en]*", "
    #         @fhtml_eng.puts_utf16 "."
    #         @fhtml_eng.puts_utf16 '</p>'
    #       end
    #     end
    #     if article[:lists] != nil and article[:lists] != [] and article[:lists] != ""
    #       @fhtml_rus.puts_utf16 '<div class="ulist">'
    #       @fhtml_rus.puts_utf16 '<div class="title">Список литературы</div>'
    #       @fhtml_rus.puts_utf16 '<ul>'
    #       article[:lists].each do |list| 
    #         while list =~ /"(.*?)"/
    #           puts "Original list: #{list}"
    #           list.sub!(/"(.*?)"/,"&lt;#{$1}&gt;")
    #           puts "Changed list: #{list}\nMust be true &lt,&gt"
    #         end
    #         @fhtml_rus.puts_utf16 "<li><p>#{list}</p></li>"
    #       end
    #       @fhtml_rus.puts_utf16 '</ul>'
    #       @fhtml_rus.puts_utf16 '</div>'
    #     end
    #     @fhtml_rus.puts_utf16 '<hr>'
    #     @fhtml_eng.puts_utf16 '<hr>'
    #     @fhtml_rus.puts_utf16 '</div>'
    #     @fhtml_eng.puts_utf16 '</div>'
    #     @fhtml_rus.puts_utf16 '</div>'
    #     @fhtml_eng.puts_utf16 '</div>'
    #   end
end
