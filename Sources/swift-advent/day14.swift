struct day14 {
    static func run() {
        var cave: [Pos] = []
        inputs.day14.mine.cleanup().split(separator: "\n").forEach { line in
            var start = Pos(-1, -1)
            line.split(separator: " -> ").map({
                $0.split(separator: ",").map({ Int($0)! })
            }).forEach { p in
                let pos = Pos(p[0], p[1])
                if start == Pos(-1, -1) {
                    start = pos
                    cave.append(start)
                } else {
                    while start.x < pos.x {
                        start.x += 1
                        cave.append(start)
                    }
                    while start.x > pos.x {
                        start.x -= 1
                        cave.append(start)
                    }
                    while start.y < pos.y {
                        start.y += 1
                        cave.append(start)
                    }
                    while start.y > pos.y {
                        start.y -= 1
                        cave.append(start)
                    }
                }
            }
        }
        
//        let minx = cave.map({ $0.x }).min()!
//        let maxx = cave.map({ $0.x }).max()!
        
        // part 1
        
//        var rested = 0
//    outer: while true {
//            var sand = Pos(500, 0)
//            while true {
//                // fall
//                if let fall = cave.filter({ $0.x == sand.x && $0.y > sand.y }).map({ $0.y }).min() {
//                    sand.y = fall-1
//                } else {
//                    break outer
//                }
//
//                // try left
//                if !cave.contains(Pos(sand.x - 1, sand.y + 1)) {
//                    sand.x -= 1
//                    sand.y += 1
//                    continue
//                }
//
//                // try right
//                if !cave.contains(Pos(sand.x + 1, sand.y + 1)) {
//                    sand.x += 1
//                    sand.y += 1
//                    continue
//                }
//
//                // rest
//                cave.append(sand)
//                rested += 1
//                break
//            }
//        }
//
//        print(rested)
        
        // part 2
        
        let floor = cave.map({ $0.y }).max()! + 2
        
        var rested = 0
    outer: while true {
            var sand = Pos(500, 0)
            while true {
                // fall
                if let fall = cave.filter({ $0.x == sand.x && $0.y > sand.y }).map({ $0.y }).min() {
                    sand.y = fall-1
                } else {
                    sand.y = floor - 1
                }

                if sand.y != floor - 1 {
                    // try left
                    if !cave.contains(Pos(sand.x - 1, sand.y + 1)) {
                        sand.x -= 1
                        sand.y += 1
                        continue
                    }

                    // try right
                    if !cave.contains(Pos(sand.x + 1, sand.y + 1)) {
                        sand.x += 1
                        sand.y += 1
                        continue
                    }
                }
                
                // rest
                cave.append(sand)
                rested += 1
                if sand == Pos(500, 0) {
                    break outer
                }
                break
            }
        }

        print(rested)
    }
}
