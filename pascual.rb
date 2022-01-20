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
  when /^([0-9]+)$/
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
  when /^load (\w+)$/
    stack.push(vars[$1])
  when /^store (\w+)$/
    vars[$1] = stack.pop
  when /^jz (\w+)$/
    idx = $1.to_i - 1 if stack.pop == 0
  when /^jnz (\w+)$/
    idx = $1.to_i - 1 unless stack.pop == 0
  when /^jmp (\w+)$/
    idx = $1.to_i - 1
  when "writeln"
    puts stack.pop
  else
    raise "unexpected instruction #{s.inspect}"
  end

  idx += 1
end
