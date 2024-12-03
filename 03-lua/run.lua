#!/usr/bin/env luajit

local p1 = 0
local p2 = 0
local enabled = true
for line in io.lines(arg[1]) do
  for i = 1, #line do
    local s = line:sub(i)
    if s:sub(1, 4) == 'do()' then
      enabled = true
    elseif s:sub(1, 7) == "don't()" then
      enabled = false
    end
    local v1, v2 = s:match('^mul%((%d+),(%d+)%)')
    if v1 then
      p1 = p1 + v1 * v2
      if enabled then
        p2 = p2 + v1 * v2
      end
    end
  end
end
print(p1)
print(p2)
