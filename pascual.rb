stack = []
vars = Hash.new(0)
code = []

while s = gets
  s.chomp!

  code << s
end

idx = 0
while idx < code.length
  s = code[idx]

  case s
  when /^(\-?[0-9]+)$/
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
    stack.push(a.fdiv b)
  when "div"
    b = stack.pop
    a = stack.pop
    stack.push(a / b)
  when "mod"
    b = stack.pop
    a = stack.pop
    stack.push(a % b)
  when "and"
    b = stack.pop
    a = stack.pop
    stack.push(a != 0 && b != 0 ? 1 : 0)
  when "or"
    b = stack.pop
    a = stack.pop
    stack.push(a != 0 || b != 0 ? 1 : 0)
  when "not"
    a = stack.pop
    stack.push(a != 0 ? 0 : 1)
  when "lt"
    b = stack.pop
    a = stack.pop
    stack.push(a < b ? 1 : 0)
  when "gt"
    b = stack.pop
    a = stack.pop
    stack.push(a > b ? 1 : 0)
  when "eq"
    b = stack.pop
    a = stack.pop
    stack.push(a == b ? 1 : 0)
  when "lte"
    b = stack.pop
    a = stack.pop
    stack.push(a <= b ? 1 : 0)
  when "gte"
    b = stack.pop
    a = stack.pop
    stack.push(a >= b ? 1 : 0)
  when "neq"
    b = stack.pop
    a = stack.pop
    stack.push(a != b ? 1 : 0)
  when /^load (\w+)$/
    stack.push(vars[$1])
  when /^store (\w+)$/
    vars[$1] = stack.pop
  when /^mkarray (\w+)$/
    a = stack.pop
    vars[$1] = Array.new(a, 0)
  when /^loadarr (\w+)$/
    a = stack.pop
    stack.push(vars[$1][a])
  when /^storearr (\w+)$/
    b = stack.pop
    a = stack.pop
    vars[$1][a] = b
  when /^jz (\w+)$/
    idx = $1.to_i - 1 if stack.pop == 0
  when /^jnz (\w+)$/
    idx = $1.to_i - 1 unless stack.pop == 0
  when /^jmp (\w+)$/
    idx = $1.to_i - 1
  when "writeln"
    puts stack.pop
  when "readln"
    stack.push(STDIN.gets.to_i)
  else
    raise "unexpected instruction #{s.inspect}"
  end

  idx += 1
end
