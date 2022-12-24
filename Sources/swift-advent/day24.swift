struct day24 {
    static func run() {
        // x grows down, y grows right
        let grid = inputs.day24.mine.lines().enumerated().reduce(into: Grid<Character>()) { acc, el in
            for (y, ch) in el.1.enumerated() {
                if ch != "#" && ch != "." {
                    acc.add(Pos(el.0 - 1, y - 1), ch)
                }
            }
        }
        
        let hl = grid.max_y + 1
        let vl = grid.max_x + 1
        
        var minute = 0
        func cross(_ start: Pos, _ end: Pos) {
            var search = [start]
            
            while !search.contains(end) {
                minute += 1
                
                let this_search = search
                search.removeAll()
                for sp in this_search {
                    // move
                    for ap in sp.around() {
                        if ap.x >= 0 && ap.x <= grid.max_x
                            && ap.y >= 0 && ap.y <= grid.max_y
                            && grid.grid[Pos(ap.x, (ap.y + minute) % hl)] != "<"
                            && grid.grid[Pos(ap.x, (hl + (ap.y - minute) % hl) % hl)] != ">"
                            && grid.grid[Pos((ap.x + minute) % vl, ap.y)] != "^"
                            && grid.grid[Pos((vl + (ap.x - minute) % vl) % vl, ap.y)] != "v"
                            && !search.contains(ap)
                        {
                            search.append(ap)
                        }
                    }
                    
                    // wait
                    if grid.grid[Pos(sp.x, (sp.y + minute) % hl)] != "<"
                        && grid.grid[Pos(sp.x, (hl + (sp.y - minute) % hl) % hl)] != ">"
                        && grid.grid[Pos((sp.x + minute) % vl, sp.y)] != "^"
                        && grid.grid[Pos((vl + (sp.x - minute) % vl) % vl, sp.y)] != "v"
                        && !search.contains(sp) {
                        search.append(sp)
                    }
                }
            }
            
            minute += 1
        }
        
        cross(Pos(-1, 0), Pos(grid.max_x, grid.max_y))
        print(minute)
        
        cross(Pos(grid.max_x + 1, grid.max_y), Pos(0, 0))
        cross(Pos(-1, 0), Pos(grid.max_x, grid.max_y))
        print(minute)
    }
}
