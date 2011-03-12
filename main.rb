 # encoding: utf-8
require 'iconv'
require 'rubygems'
#require 'ruby-debug'
@@converter = Iconv.new("UTF-16LE", "UTF-8")
class IO
  def puts_utf16
    puts
  end
  def print_utf16
    print
  end
  def puts_utf16 s
    puts s
  end
  def print_utf16 s
    print s
  end
end

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__)))

require 'lib/mfe.rb'
require 'lib/main_read.rb'
require 'lib/another_read.rb'
require 'lib/check.rb'
require 'lib/output_xml.rb'
require 'lib/mfm.rb'
require 'lib/output_html.rb'


#TYPES = ["RAR", "REV"]
ATTRS = ["-e", "--help", "-h", "-help", "-s", "-ch", "-xml", "-m", "-f", "-no", "-php", "-doc"]
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
params = {:pr_type => 1, :check => 0, :oxml => 0, :ohtml => 0, :mfm => 0, :mfs => 0}
pr_type = 1
check = 0
oxml = 0
ohtml = 0
mfm = 0
mfs = 0
i = 0
finfl = false
while i < ARGV.size
  arg = ARGV[i]
  case ATTRS.index(arg.strip)
  when 0
    params[:pr_type] = 0
    if (i += 1) >= ARGV.size
      $stderr.puts '-e Error. Use "-e File".'
      exit
    end
    @fout = File.new(ARGV[i], "w")
  when 1..3
    printf("%22s = %s\n", "--help || -h || -help", "This help")
    printf("%22s = %s\n", "-e file", "Make for english")
    printf("%22s = %s\n", "-s file", "Make from several")
    printf("%22s = %s\n", "-ch number_name (nn_yyyy)", "Check number")
    printf("%22s = %s\n", "-xml file", "Output xml if file")
    printf("%22s = %s\n", "-f file", "Main file. Don't use with -doc.")
    printf("%22s = %s\n", "-no log_file", "Output NoItem in log_file" )
    printf("%22s = %s\n", "-php file_rus file_eng", "Make php in files" )
    printf("%22s = %s\n", "-doc file.doc", "Main file doc. Don't use with -f." )
    exit
  when 4
    params[:mfs] = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-s Error. Use "-s File".'
      exit
    end
    @fsecond = File.new(ARGV[i], "r")
  when 5
    params[:check] = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-ch Error. Use "-ch number_name".'
      exit
    end
    number_name = ARGV[i]
  when 6
    params[:oxml] = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-xml Error. Use "-xml File".'
      exit
    end
    @fxml = File.new(ARGV[i],"w")
  when 7
    params[:mfm] = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-xml Error. Use "-xml File".'
      exit
    end
    if !(@fout)
      @fout = File.new(ARGV[i],"w")
    end
  when 8
    if (i += 1) >= ARGV.size
      $stderr.puts '-f Error. Use "-f File".'
      exit
    end
    unless finfl
      @fin = File.new(ARGV[i],"r")
      finfl = true
    else
      $stderr.puts 'Don\'t use -f and -doc simultaneously.'
      exit
    end
  when 9
    if (i += 1) >= ARGV.size
      $stderr.puts '-f Error. Use "-f File".'
      exit
    end
    @flog = File.new(ARGV[i],"w")
  when 10
    params[:ohtml] = 1
    if (i += 1) >= ARGV.size
      $stderr.puts '-html Error. Use "-php File_Rus File_Eng".'
      exit
    end
    @fhtml_rus = File.new(ARGV[i],"w")
    if (i += 1) >= ARGV.size
      $stderr.puts '-html Error. Use "-php File_Rus File_Eng".'
      exit
    end
    @fhtml_eng = File.new(ARGV[i],"w")
  when 11
    if (i += 1) >= ARGV.size or ARGV[i] !~ /\.docx?$/
      $stderr.puts '-doc Error. Use "-doc File.doc(x)".'
      exit
    end
    unless finfl
      system "antiword '#{ARGV[i]}' > #{ARGV[i]}.txt"
      @fin = File.new(ARGV[i] + ".txt", "r")
      finfl = true
    else
      $stderr.puts 'Don\'t use -f and -doc simultaneously.'
      exit
    end
  when nil  
    $stderr.puts "Error input. Use '--help'"
    exit
  else
    $stderr.puts "Error input. Use '--help'"
    exit
  end
  i += 1
end

case params[:pr_type]
when 0
  articles = main_read()
  mfe(articles)
  if params[:check] == 1    
    check(articles)
  end
when 1
  articles = main_read()
  if params[:mfs] == 1
    buf = another_read(articles.dup)
    articles.each_with_index{|a, i| a.merge buf[i]}
  end
  if params[:check] == 1
    check(articles, number_name)
  end
  if params[:mfm] == 1
    mfm(articles)
  end
  if params[:oxml] == 1
    puts "Make XML?(y/n)"
    while $stdin.gets.strip != "y"
      if $_.strip == "n"
        exit
      end
    end
    output_xml(articles)
  end
  if params[:ohtml] == 1
    puts "Make PHP?(y/n)"
    while $stdin.gets.strip != "y"
      if $_.strip == "n"
        exit
      end
    end
    output_html(articles)
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
