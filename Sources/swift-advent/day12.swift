struct day12 {
    static func run() {
        var hmap = Grid<UInt8>()
        
        var start = Pos(-1, -1)
        var end = Pos(-1, -1)
        
        inputs.day12.mine.cleanup().split(separator: "\n").indexed().forEach { (x, line) in
            var y = 0
            line.forEach { ch in
                var v : UInt8
                if ch == "S" {
                    start = Pos(x, y)
                    v = 0
                } else if ch == "E" {
                    end = Pos(x, y)
                    v = 26
                } else {
                    v = ch.asciiValue! - Character("a").asciiValue!
                }
                hmap.add(Pos(x, y), v)
                y += 1
            }
        }
        
        do {
            var visited: Set<Pos> = Set()
            var next_visit = Set([start])
            var steps = 0
            outer: while next_visit.count > 0 && !visited.contains(end) {
                var this_visit = next_visit
                next_visit.removeAll()
                
                while let nv = this_visit.popFirst() {
                    if nv == end {
                        break outer
                    }
                    visited.insert(nv)
                    
                    nv.around().filter { p in
                        hmap.inbound(p) && !visited.contains(p)
                    }.forEach { p in
                        if hmap.grid[p]! <= hmap.grid[nv]! + 1 {
                            next_visit.insert(p)
                        }
                    }
                }
                steps += 1
            }
            
            print(steps)
        }
        
        
        // part 2
        
        do {
            var visited: Set<Pos> = Set()
            var next_visit = Set([end])
            var steps = 0
            outer: while next_visit.count > 0 {
                var this_visit = next_visit
                next_visit.removeAll()
                
                while let nv = this_visit.popFirst() {
                    if hmap.grid[nv]! == 0 {
                        break outer
                    }
                    visited.insert(nv)
                    
                    nv.around().filter { p in
                        hmap.inbound(p) && !visited.contains(p)
                    }.forEach { p in
                        if hmap.grid[p]! >= hmap.grid[nv]! - 1 {
                            next_visit.insert(p)
                        }
                    }
                }
                steps += 1
            }
            
            print(steps)
        }
    }
}
