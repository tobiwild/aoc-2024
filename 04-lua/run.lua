#!/usr/bin/env luajit

local grid = {}
for line in io.lines(arg[1]) do
  local row = {}
  for c in line:gmatch(".") do
    table.insert(row, c)
  end
  table.insert(grid, row)
end

local rows = #grid
local cols = #grid[1]

do
  local dirs = {
    { -1, 0 },
    { -1, 1 },
    { -1, -1 },
    { 1, 0 },
    { 1, 1 },
    { 1, -1 },
    { 0, 1 },
    { 0, -1 },
  }

  local p1 = 0
  for row = 1, rows do
    for col = 1, cols do
      if grid[row][col] == "X" then
        for _, dir in ipairs(dirs) do
          local r, c = row, col
          local search = { "M", "A", "S" }
          local i = 0
          while true do
            i = i + 1
            r = r + dir[1]
            c = c + dir[2]
            if not (r >= 1 and r <= rows and c >= 1 and c <= cols) then
              break
            end
            if grid[r][c] ~= search[i] then
              break
            end
            if i == #search then
              p1 = p1 + 1
              break
            end
          end
        end
      end
    end
  end
  print(p1)
end

do
  local dirs = {
    { "A", { -1, -1 } },
    { "A", { 1, 1 } },
    { "B", { -1, 1 } },
    { "B", { 1, -1 } },
  }

  local function smChars(chars)
    return chars.A and chars.A.S and chars.A.M and chars.B and chars.B.S and chars.B.M
  end

  local p2 = 0
  for row = 1, rows do
    for col = 1, cols do
      if grid[row][col] == "A" then
        local chars = {}
        for _, dir in ipairs(dirs) do
          local key = dir[1]
          local r = row + dir[2][1]
          local c = col + dir[2][2]
          if r >= 1 and r <= rows and c >= 1 and c <= cols then
            chars[key] = chars[key] or {}
            chars[key][grid[r][c]] = true
          end
        end
        if smChars(chars) then
          p2 = p2 + 1
        end
      end
    end
  end
  print(p2)
end
