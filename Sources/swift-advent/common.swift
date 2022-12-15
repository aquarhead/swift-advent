extension String {
    func cleanup() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func lines() -> [String] {
        self.cleanup().split(separator: "\n").map({ String($0) })
    }
}

struct Pos: Hashable {
    var x: Int
    var y: Int
    
    init(_ xi: Int, _ yi: Int) {
        x = xi
        y = yi
    }
    
    func around() -> [Pos] {
        [
            Pos(x - 1, y),
            Pos(x + 1, y),
            Pos(x, y - 1),
            Pos(x, y + 1),
        ]
    }
    
    func md(_ other: Self) -> Int {
        abs(x - other.x) + abs(y - other.y)
    }
}

struct Grid<T> {
    var grid: [Pos:T] = [:]
    
    var max_x = -1
    var max_y = -1
    
    mutating func add(_ p: Pos, _ v: T) {
        grid[p] = v
        if p.x > max_x {
            max_x = p.x
        }
        
        if p.y > max_y {
            max_y = p.y
        }
    }
    
    func inbound(_ p: Pos) -> Bool {
        p.x >= 0 && p.x <= max_x && p.y >= 0 && p.y <= max_y
    }
}
