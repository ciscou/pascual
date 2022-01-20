stack = []
vars = Hash.new(0)

while s = gets
  s.chomp!

  case s
  when /([0-9]+)/
    stack.push $1.to_i
  when "+"
    b = stack.pop
    a = stack.pop
    stack.push(a + b)
  when "-"
    b = stack.pop
    a = stack.pop
    stack.push(a - b)
  when "*"
    b = stack.pop
    a = stack.pop
    stack.push(a * b)
  when "/"
    b = stack.pop
    a = stack.pop
    stack.push(a / b)
  when /^load (\w+)$/
    stack.push(vars[$1])
  when /^store (\w+)$/
    vars[$1] = stack.pop
  when "writeln"
    puts stack.pop
  else
    raise "unexpected instruction #{s.inspect}"
  end
end
