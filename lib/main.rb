# -*- coding: utf-8 -*-
$KCODE = 'UTF-16LE'
require 'mfe.rb'
require 'main_read.rb'
require 'another_read.rb'
require 'check.rb'
require 'output_xml.rb'
require 'mfm.rb'


#TYPES = ["RAR", "REV"]
PARAMS = ["-e", "-help", "-s", "-ch", "-xml", "-m", "-f", "-no"]
AUTHOR_SYM = [:name_rus, :name_en, :adress_rus, :adress_en, :workplace_rus, :workplace_en]


# -m -- Make for mama
# -e -- Make for english
# -help -- params
# -s -- make from several
# -ch -- check 
# -xml -- Output xml in fourth file
# -f -- Main file

#author = Struct.new(:name_rus, :name_en, :adress_rus, :adress_en, :workplace_rus, :workplace_en)
#article -- :section_rus, :section_en, :pages, :type, :authors, :title_rus, :title_en, 
#           :summary_rus, :summary_en, :keywords_rus, :keywords_en, :lists
#if ARGV.size < 2
#  $stderr.puts "0:Enter files, please!"
#  exit
#end
k = 0
pr_type = 0
check = 0
oxml = 0
mfm = 0
i = 0
while i < ARGV.size
  arg = ARGV[i]
  case PARAMS.index(arg.chomp)
  when 0
    pr_type = 0
    if (i += 1) >= ARGV.size
      $stderr.puts '-e Error. Use "-e File".'
      exit
    end
    @fout = File.new(ARGV[i], "w")
  when 1
    printf("%-10s - %s\n", "-e file", "Make for english")
    printf("%-10s - %s\n", "-help", "Parameters")
    printf("%-10s - %s\n", "-s file", "Make from several")
    printf("%-10s - %s\n", "-ch", "Check")
    printf("%-10s - %s\n", "-xml file", "Output xml if file")
    printf("%-10s - %s\n", "-f file", "Main file")
    printf("%-10s - %s\n", "-no log_file", "Output NoItem in log_file" )
    printf("%-10s - %s\n", "files: ", "first, out, second")
    exit
  when 2
    pr_type = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-s Error. Use "-s File".'
      exit
    end
    @fsecond = File.new(ARGV[i], "r")
  when 3
    check = 1
  when 4
    oxml = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-xml Error. Use "-xml File".'
      exit
    end
    @fxml = File.new(ARGV[i],"w")
  when 5
    mfm = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-xml Error. Use "-xml File".'
      exit
    end
    if !(@fout)
      @fout = File.new(ARGV[i],"w")
    end
  when 6
    if (i += 1) >= ARGV.size
      $stderr.puts '-f Error. Use "-f File".'
      exit
    end
    @fin = File.new(ARGV[i],"r")
  when 7
    if (i += 1) >= ARGV.size
      $stderr.puts '-f Error. Use "-f File".'
      exit
    end
    @flog = File.new(ARGV[i],"w")
  when nil  
    $stderr.puts "Error input. Use '-help'"
    exit
  else
    $stderr.puts "Error input. Use '-help'"
    exit
  end
  i += 1
end

case pr_type 
when 0
  articles = main_read()
  mfe(articles)
  if check == 1    
    check(articles)
  end
when 1
  articles = main_read()
  articles = another_read(articles)
  if check == 1
    check(articles)
  end
  if mfm == 1
    mfm(articles)
  end
  if oxml == 1
    puts "Make XML?(y/n)"
    while $stdin.gets.strip != "y"
      if $_.strip == "n"
        exit
      end
    end
    output_xml(articles)
  end
end
@fin.close
if @flog
  @flog.close
end
if @fout
  @fout.close
end
if @fsecond
  @fsecond.close
end
if @xml
  @xml.close
end
