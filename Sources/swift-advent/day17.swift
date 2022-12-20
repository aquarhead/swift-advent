struct day17 {
    enum RockType: Int {
        // #c##
        case HLine
        
        //  #
        // #c#
        //  #
        case Cross
        
        //   #
        //   #
        // ##c
        case L
        
        // #
        // c
        // #
        // #
        case VLine
        
        // c#
        // ##
        case Square
    }
    
    struct Rock {
        let typ: RockType
        
        // x grows up, y grows right
        var center: Pos
        
        init(_ typ: RockType, _ prev_max_y: Int) {
            self.typ = typ
            switch typ {
            case .HLine:
                center = Pos(4, prev_max_y + 4)
            case .Cross:
                center = Pos(4, prev_max_y + 5)
            case .L:
                center = Pos(5, prev_max_y + 4)
            case .VLine:
                center = Pos(3, prev_max_y + 6)
            case .Square:
                center = Pos(3, prev_max_y + 5)
            }
        }
        
        func body() -> [Pos] {
            switch typ {
            case .HLine:
                return [
                    Pos(center.x - 1, center.y),
                    Pos(center.x, center.y),
                    Pos(center.x + 1, center.y),
                    Pos(center.x + 2, center.y),
                ]
            case .Cross:
                return [
                    Pos(center.x, center.y - 1),
                    Pos(center.x - 1, center.y),
                    Pos(center.x, center.y),
                    Pos(center.x, center.y + 1),
                    Pos(center.x + 1, center.y),
                ]
            case .L:
                return [
                    Pos(center.x - 2, center.y),
                    Pos(center.x - 1, center.y),
                    Pos(center.x, center.y),
                    Pos(center.x, center.y + 1),
                    Pos(center.x, center.y + 2),
                ]
            case .VLine:
                return [
                    Pos(center.x, center.y + 1),
                    Pos(center.x, center.y),
                    Pos(center.x, center.y - 1),
                    Pos(center.x, center.y - 2),
                ]
            case .Square:
                return [
                    Pos(center.x, center.y),
                    Pos(center.x + 1, center.y),
                    Pos(center.x, center.y - 1),
                    Pos(center.x + 1, center.y - 1),
                ]
            }
        }
    }
    
    static func run() {
        let jet: Array<Character> = Array(inputs.day17.mine.cleanup())
        
        // part 1
        do {
            var grid: Set<Pos> = Set()
            var max_y = 0
            for x in 1...7 {
                grid.insert(Pos(x, 0))
            }
            
            var jet_idx = 0
            for n in 0..<2022 {
                var r = Rock(RockType.init(rawValue: n % 5)!, max_y)
                while true {
                    jet_idx %= jet.count
                    switch jet[jet_idx] {
                    case "<":
                        r.center.x -= 1
                        if r.body().contains(where: { $0.x <= 0 || grid.contains($0) }) {
                            r.center.x += 1
                        }
                    default:
                        r.center.x += 1
                        if r.body().contains(where: { $0.x >= 8 || grid.contains($0) }) {
                            r.center.x -= 1
                        }
                    }
                    jet_idx += 1
                    
                    r.center.y -= 1
                    if r.body().contains(where: { grid.contains($0) }) {
                        r.center.y += 1
                        break
                    }
                }
                r.body().forEach({ grid.insert($0) })
                max_y = max(max_y, r.body().map({ $0.y }).max()!)
            }
            
            print(max_y)
        }
        
        // part 2
        do {
            var grid: Set<Pos> = Set()
            var max_y = 0
            for x in 1...7 {
                grid.insert(Pos(x, 0))
            }
            
            var jet_idx = 0

            var repeat_start = 0
            var repeat_inc = 0
            var repeating: [(Int, Int)] = []
            var n = 0
            while true {
                if (n % 5 == 0) {
                    if let idx =  repeating.firstIndex(where: {jet_idx % jet.count == $0.0}) {
                        repeat_start = idx
                        repeat_inc = max_y - repeating[repeat_start].1
                        break
                    }
                    repeating.append((jet_idx % jet.count, max_y))
                }
                var r = Rock(RockType.init(rawValue: n % 5)!, max_y)
                while true {
                    switch jet[jet_idx % jet.count] {
                    case "<":
                        r.center.x -= 1
                        if r.body().contains(where: { $0.x <= 0 || grid.contains($0) }) {
                            r.center.x += 1
                        }
                    default:
                        r.center.x += 1
                        if r.body().contains(where: { $0.x >= 8 || grid.contains($0) }) {
                            r.center.x -= 1
                        }
                    }
                    jet_idx += 1
                    
                    r.center.y -= 1
                    if r.body().contains(where: { grid.contains($0) }) {
                        r.center.y += 1
                        break
                    }
                }
                r.body().forEach({ grid.insert($0) })
                max_y = max(max_y, r.body().map({ $0.y }).max()!)
                n += 1
            }
            
            let repeat_len = repeating.count - repeat_start
            let repeats = ((1000000000000 / 5) - repeat_start)
            
            print(repeats / repeat_len * repeat_inc + repeating[repeat_start + (repeats % repeat_len)].1)
        }
    }
}
