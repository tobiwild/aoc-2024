package main

import (
	"bufio"
	"fmt"
	"os"
)

type xy struct {
	x, y int
}

func turnRight(pos xy) xy {
	switch pos {
	case xy{0, -1}:
		return xy{1, 0}
	case xy{1, 0}:
		return xy{0, 1}
	case xy{0, 1}:
		return xy{-1, 0}
	case xy{-1, 0}:
		return xy{0, -1}
	}
	panic("invalid pos")
}

type posDir struct {
	pos, dir xy
}

func visitedBeforeLeaving(cur, dim xy, blocked map[xy]bool) int {
	dir := xy{0, -1}
	visited := make(map[xy]bool)
	visitedDirs := make(map[posDir]bool)
	visited[cur] = true
	visitedDirs[posDir{cur, dir}] = true

	for {
		n := xy{cur.x + dir.x, cur.y + dir.y}
		if n.x < 0 || n.x >= dim.x || n.y < 0 || n.y >= dim.y {
			break
		}
		if blocked[n] {
			dir = turnRight(dir)
		} else {
			posDir := posDir{n, dir}
			if visitedDirs[posDir] {
				// in loop
				return -1
			}
			visited[n] = true
			visitedDirs[posDir] = true
			cur = n
		}
	}

	return len(visited)
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	blocked := make(map[xy]bool)
	var cur, dim xy

	for scanner.Scan() {
		dim.x = 0
		for _, b := range scanner.Bytes() {
			if b == '#' {
				blocked[dim] = true
			} else if b == '^' {
				cur = dim
			}
			dim.x++
		}
		dim.y++
	}

	fmt.Printf("%v\n", visitedBeforeLeaving(cur, dim, blocked))

	var p2 int
	for y := 0; y < dim.y; y++ {
		for x := 0; x < dim.x; x++ {
			pos := xy{x, y}
			if blocked[pos] {
				continue
			}
			blocked[pos] = true
			if visitedBeforeLeaving(cur, dim, blocked) == -1 {
				p2++
			}
			blocked[pos] = false
		}
	}
	fmt.Printf("%v\n", p2)
}
