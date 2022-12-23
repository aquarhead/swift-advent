struct day23 {
    enum Direction: Int {
        case north, south, west, east
    }
    
    static func run() {
        // x grows down, y grows right
        let elves = inputs.day23.mine.lines().enumerated().flatMap { (x, line) in
            line.enumerated().filter({ $0.1 == "#" }).map({ Pos(x, $0.0) })
        }
        
        let nel = elves.count
        
        func adj(_ p: Pos, _ d: Direction) -> (Pos, [Pos]) {
            switch d {
            case .north:
                return (Pos(p.x - 1, p.y), [Pos(p.x - 1, p.y), Pos(p.x - 1, p.y - 1), Pos(p.x - 1, p.y + 1)])
            case .south:
                return (Pos(p.x + 1, p.y), [Pos(p.x + 1, p.y), Pos(p.x + 1, p.y - 1), Pos(p.x + 1, p.y + 1)])
            case .west:
                return (Pos(p.x, p.y - 1), [Pos(p.x, p.y - 1), Pos(p.x - 1, p.y - 1), Pos(p.x + 1, p.y - 1)])
            case .east:
                return (Pos(p.x, p.y + 1), [Pos(p.x, p.y + 1), Pos(p.x - 1, p.y + 1), Pos(p.x + 1, p.y + 1)])
            }
        }
        
        // part 1
        do {
            var cur_pos = elves
            for round in 0..<10 {
                let new_pos = cur_pos.map { cp in
                    let around = cp.around8()
                    if cur_pos.contains(where: { around.contains($0) }) {
                        for dv in 0..<4 {
                            let (np, aa) = adj(cp, Direction(rawValue: (round + dv) % 4)!)
                            if !cur_pos.contains(where: { aa.contains($0) }) {
                                return np
                            }
                        }
                    }
                    return cp
                }
                
                for i in 0..<nel {
                    if new_pos[i] != cur_pos[i] && !new_pos.enumerated().contains(where: { $0.0 != i && $0.1 == new_pos[i] }) {
                        cur_pos[i] = new_pos[i]
                    }
                }
            }
            
            let (xa, xb) = cur_pos.map({ $0.x }).minAndMax()!
            let (ya, yb) = cur_pos.map({ $0.y }).minAndMax()!
            
            print( (xb - xa + 1) * (yb - ya + 1) - nel )
        }
        
        // part 2
        do {
            var cur_pos = elves
            var round = 0
            while true {
                let new_pos = cur_pos.map { cp in
                    let around = cp.around8()
                    if cur_pos.contains(where: { around.contains($0) }) {
                        for dv in 0..<4 {
                            let (np, aa) = adj(cp, Direction(rawValue: (round + dv) % 4)!)
                            if !cur_pos.contains(where: { aa.contains($0) }) {
                                return np
                            }
                        }
                    }
                    return cp
                }
                
                var moved = false
                for i in 0..<nel {
                    if new_pos[i] != cur_pos[i] && !new_pos.enumerated().contains(where: { $0.0 != i && $0.1 == new_pos[i] }) {
                        moved = true
                        cur_pos[i] = new_pos[i]
                    }
                }
                
                round += 1
                if !moved {
                    break
                }
            }
            
            print(round)
        }
    }
}
