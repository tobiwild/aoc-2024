#!/usr/bin/env ruby
# frozen_string_literal: true

def safe?(nums)
  range = nums[0] > nums[1] ? (-3..-1) : (1..3)
  nums
    .each_cons(2)
    .all? { range.include?(_2 - _1) }
end

def safe_with_one_removed?(nums)
  nums.size.times do |i|
    new_nums = nums.dup
    new_nums.delete_at(i)
    return true if safe?(new_nums)
  end
  false
end

p1 = 0
p2 = 0

ARGF.each_line do |line|
  nums = line.split.map(&:to_i)
  if safe?(nums)
    p1 += 1
    p2 += 1
  elsif safe_with_one_removed?(nums)
    p2 += 1
  end
end

puts p1
puts p2
