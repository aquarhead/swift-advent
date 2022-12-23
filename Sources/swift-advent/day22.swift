struct day22 {
    enum Direction: Int {
        case east, south, west, north
    }
    
    static func run() {
        let s = inputs.day22.mine.split(separator: "\n\n")
        
        var grid: [Pos:Bool] = [:]
        
        // x grows down, y grows right
        var x = 1
        s[0].split(separator: "\n").forEach { line in
            var y = 1
            for ch in String(line) {
                switch ch {
                case ".":
                    grid[Pos(x, y)] = true
                case "#":
                    grid[Pos(x, y)] = false
                default:
                    ()
                }
                
                y += 1
            }
            x += 1
        }
        
        // part 1
        do {
            var cur_pos = grid.filter({ $0.value }).keys.filter({ $0.x == 1 }).min(by: { $0.y < $1.y })!
            var cur_dir = Direction.east
            
            func walk(_ n: Int) {
                for _ in 0..<n {
                    var new_pos = cur_pos
                    switch cur_dir {
                    case .north:
                        new_pos.x -= 1
                    case .east:
                        new_pos.y += 1
                    case .south:
                        new_pos.x += 1
                    case .west:
                        new_pos.y -= 1
                    }
                    
                    if let g = grid[new_pos] {
                        if g {
                            cur_pos = new_pos
                        } else {
                            return
                        }
                    } else {
                        switch cur_dir {
                        case .north:
                            new_pos = grid.keys.filter({ $0.y == new_pos.y }).max(by: { $0.x < $1.x })!
                        case .east:
                            new_pos = grid.keys.filter({ $0.x == new_pos.x }).min(by: { $0.y < $1.y })!
                        case .south:
                            new_pos = grid.keys.filter({ $0.y == new_pos.y }).min(by: { $0.x < $1.x })!
                        case .west:
                            new_pos = grid.keys.filter({ $0.x == new_pos.x }).max(by: { $0.y < $1.y })!
                        }
                        
                        if grid[new_pos]! {
                            cur_pos = new_pos
                        } else {
                            return
                        }
                    }
                }
            }
            
            var inst = s[1]
            
            while true {
                if let idx = inst.firstIndex(where: { $0 == "R" || $0 == "L" }) {
                    let steps = Int(inst[inst.startIndex..<idx])!
                    
                    walk(steps)
                    
                    inst.removeSubrange(inst.startIndex..<idx)
                    switch inst.removeFirst() {
                    case "R":
                        cur_dir = Direction(rawValue: (cur_dir.rawValue + 1) % 4)!
                    default:
                        cur_dir = Direction(rawValue: (cur_dir.rawValue + 3) % 4)!
                    }
                } else {
                    let steps = Int(inst)!
                    walk(steps)
                    break
                }
            }
            print(1000 * cur_pos.x + 4 * cur_pos.y + cur_dir.rawValue)
        }
        
        // part 2
        do {
            var cur_pos = grid.filter({ $0.value }).keys.filter({ $0.x == 1 }).min(by: { $0.y < $1.y })!
            var cur_dir = Direction.east
            
            func walk(_ n: Int) {
                for _ in 0..<n {
                    var new_pos = cur_pos
                    switch cur_dir {
                    case .north:
                        new_pos.x -= 1
                    case .east:
                        new_pos.y += 1
                    case .south:
                        new_pos.x += 1
                    case .west:
                        new_pos.y -= 1
                    }
                    
                    if let g = grid[new_pos] {
                        if g {
                            cur_pos = new_pos
                        } else {
                            return
                        }
                    } else {
                        // my shape
                        //  AB
                        //  C
                        // ED
                        // F
                        
                        var new_dir = Direction.north
                        
                        switch cur_dir {
                        case .north:
                            switch (cur_pos.x, cur_pos.y) {
                            case (1, 51...100):
                                // A
                                new_pos = Pos(150 + cur_pos.y - 50, 1)
                                new_dir = .east
                            case (1, 101...150):
                                // B
                                new_pos = Pos(200, cur_pos.y - 100)
                                new_dir = .north
                            case (101, 1...50):
                                // E
                                new_pos = Pos(50 + cur_pos.y, 51)
                                new_dir = .east
                            default:
                                print(".north IMPOSSIBLE")
                            }
                        case .east:
                            switch (cur_pos.x, cur_pos.y) {
                            case (1...50, 150):
                                // B
                                new_pos = Pos(101 + 50 - cur_pos.x, 100)
                                new_dir = .west
                            case (51...100, 100):
                                // C
                                new_pos = Pos(50, 100 + cur_pos.x - 50)
                                new_dir = .north
                            case (101...150, 100):
                                // D
                                new_pos = Pos(151 - cur_pos.x, 150)
                                new_dir = .west
                            case (151...200, 50):
                                // F
                                new_pos = Pos(150, 50 + cur_pos.x - 150)
                                new_dir = .north
                            default:
                                print(".east IMPOSSIBLE")
                            }
                        case .south:
                            switch (cur_pos.x, cur_pos.y) {
                            case (50, 101...150):
                                // B
                                new_pos = Pos(50 + cur_pos.y - 100, 100)
                                new_dir = .west
                            case (150, 51...100):
                                // D
                                new_pos = Pos(150 + cur_pos.y - 50, 50)
                                new_dir = .west
                            case (200, 1...50):
                                // F
                                new_pos = Pos(1, 100 + cur_pos.y)
                                new_dir = .south
                            default:
                                print(".south IMPOSSIBLE")
                            }
                        case .west:
                            switch (cur_pos.x, cur_pos.y) {
                            case (1...50, 51):
                                // A
                                new_pos = Pos(151 - cur_pos.x, 1)
                                new_dir = .east
                            case (51...100, 51):
                                // C
                                new_pos = Pos(101, cur_pos.x - 50)
                                new_dir = .south
                            case (101...150, 1):
                                // E
                                new_pos = Pos(151 - cur_pos.x, 51)
                                new_dir = .east
                            case (151...200, 1):
                                // F
                                new_pos = Pos(1, 50 + cur_pos.x - 150)
                                new_dir = .south
                            default:
                                print(".west IMPOSSIBLE")
                            }
                        }
                        
                        if grid[new_pos]! {
                            cur_pos = new_pos
                            cur_dir = new_dir
                        } else {
                            return
                        }
                    }
                }
            }
            
            var inst = s[1]
            
            while true {
                if let idx = inst.firstIndex(where: { $0 == "R" || $0 == "L" }) {
                    let steps = Int(inst[inst.startIndex..<idx])!
                    
                    walk(steps)
                    
                    inst.removeSubrange(inst.startIndex..<idx)
                    switch inst.removeFirst() {
                    case "R":
                        cur_dir = Direction(rawValue: (cur_dir.rawValue + 1) % 4)!
                    default:
                        cur_dir = Direction(rawValue: (cur_dir.rawValue + 3) % 4)!
                    }
                } else {
                    let steps = Int(inst)!
                    walk(steps)
                    break
                }
            }
            print(1000 * cur_pos.x + 4 * cur_pos.y + cur_dir.rawValue)
        }
    }
}
