struct day18 {
    static func run() {
        let cubes = inputs.day18.mine.lines().map { line in
            let x = line.split(separator: ",").map({ Int($0)! })
            return (x[0], x[1], x[2])
        }
        
        var part1 = cubes.count * 6
        for i in cubes {
            for j in cubes {
                if i != j {
                    if (abs(i.0 - j.0) + abs(i.1 - j.1) + abs(i.2 - j.2)) == 1 {
                        part1 -= 1
                    }
                }
            }
        }
        
        print(part1)
        
        func around(_ x: (Int, Int, Int)) -> [(Int, Int, Int)] {
            [
                (x.0 - 1, x.1, x.2),
                (x.0 + 1, x.1, x.2),
                (x.0, x.1 - 1, x.2),
                (x.0, x.1 + 1, x.2),
                (x.0, x.1, x.2 - 1),
                (x.0, x.1, x.2 + 1),
            ]
        }
        
        let minx = cubes.map({ $0.0 }).min()!
        let maxx = cubes.map({ $0.0 }).max()!
        let miny = cubes.map({ $0.1 }).min()!
        let maxy = cubes.map({ $0.1 }).max()!
        let minz = cubes.map({ $0.2 }).min()!
        let maxz = cubes.map({ $0.2 }).max()!
        
        func inbound(_ x: (Int, Int, Int)) -> Bool {
            (x.0 >= minx - 1) &&
            (x.0 <= maxx + 1) &&
            (x.1 >= miny - 1) &&
            (x.1 <= maxy + 1) &&
            (x.2 >= minz - 1) &&
            (x.2 <= maxz + 1)
        }
        
        var steams: [(Int, Int, Int)] = []
        var search = [(minx - 1, miny - 1, minz - 1)]
        
        var part2 = 0
        while search.count > 0 {
            steams.append(contentsOf: search)
            var new_search: [(Int, Int, Int)] = []
            for s in search {
                part2 += cubes.filter({ (abs($0.0 - s.0) + abs($0.1 - s.1) + abs($0.2 - s.2)) == 1 }).count
                
                for ns in around(s) {
                    if inbound(ns) && !steams.contains(where: { $0 == ns }) && !cubes.contains(where: { $0 == ns }) && !new_search.contains(where: {$0 == ns}) {
                        new_search.append(ns)
                    }
                }
            }
            
            search = new_search
        }
        
        print(part2)
    }
}
