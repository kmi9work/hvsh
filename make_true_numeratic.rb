
arr= %w(a b c d e f g h i j k l)
i = 0
j = 0
while gets
  if $_ =~ /^[a-l]\)(.*)/
    
    puts "#{arr[i]})#{$1}"
    i += 1
   # $stderr.puts $.
  elsif $_.strip == "-"
    i = 0
    puts "-"
  elsif $_.strip =~ /^-[^abcdef](.+)/
    puts "-#{arr[j]} #{$1}"
    j >= 5 ? j = 0 : j += 1
  elsif $_.strip =~ /^-[abcdef](.+)/
    puts "-#{arr[j]} #{$1}"
    j >= 5 ? j = 0 : j += 1  
  else
    puts $_
  end
end

