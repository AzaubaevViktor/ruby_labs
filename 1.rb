# frozen_string_literal: true

# @param [Array] arr
def uniq(arr)
  arr.reduce([]) { |item, ch| item.include?(ch) ? item : item + [ch] }
end

raise 'WRONG' unless uniq([1, 1, 1, 1, 1]) == [1]
raise 'WRONG' unless uniq([1, 1, 2, 1, 3]) == [1, 2, 3]
raise 'WRONG' unless uniq([1, 1, 2, 4, 3]) == [1, 2, 4, 3]

# @param [Array] arr
# @param [Integer] level
def permute_ng(arr, level)
  return [] if level > arr.length

  case level
  when 1
    arr.map { |item| [item] }
  else
    ((1..level - 1).reduce(arr) \
    { |a| a.product(arr) }).map \
    { |item| item.flatten(level - 1) }.select \
    { |permute_item| permute_item.length == permute_item.uniq.length }
  end
end

# @param [Array] source
# @param [Integer] level
def check(source, level)
  source = uniq source

  print "\nLEVEL ", level, "\n"
  my = permute_ng(source, level)
  orig = source.permutation(level).to_a
  print 'MY  :', my
  print "\n"
  print 'ORIG:', orig
  print "\n"
  (my.zip orig).each do |(x, y)|
    raise format('WRONG %d: %s %s', level, x, y) unless my == orig
  end
end

(1..10).each { |level| check [1, 2, 2, 3, 5, 1, 4, 5], level }
