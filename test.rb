def percentage_point(a, b)
  r = (b * 100) / a

  if a > b
    r = r - 100
  elsif b > a
    r = 100 - r
  # elsif
  end

  return r
end

puts percentage_point(10, 40)
puts percentage_point(40, 10)