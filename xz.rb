arr= %w(a b c d e f)
i = 0
k = 0
while gets
  if $_ =~ /^-\ (.*)/
    puts "a#{k}" if i == 0
    puts "-#{arr[i]} #{$1}"
    i += 1
  elsif $_ =~ /^[a-l]\).*/
    puts $_
    i = 0
  elsif $_.strip == "-"
    k = 0
  else
    puts $_
  end
  i = 0 if i > 5
end
