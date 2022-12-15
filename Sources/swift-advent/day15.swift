import RegexBuilder

struct day15 {
    static func run() {
        let parser = Regex {
            "Sensor at x="
            Capture {
                Optionally("-")
                OneOrMore(.digit)
            }
            ", y="
            Capture {
                Optionally("-")
                OneOrMore(.digit)
            }
            ": closest beacon is at x="
            Capture {
                Optionally("-")
                OneOrMore(.digit)
            }
            ", y="
            Capture {
                Optionally("-")
                OneOrMore(.digit)
            }
        }
        
        let sbs = inputs.day15.mine.lines().map { line in
            let m = try? parser.wholeMatch(in: line)
            let sensor = Pos(Int(m!.1)!, Int(m!.2)!)
            let beacon = Pos(Int(m!.3)!, Int(m!.4)!)
            return (sensor, beacon)
        }
        
        // part 1
        do {
            let target_y = 2000000
            
            var ranges = sbs.flatMap { (sensor, beacon) in
                let md = sensor.md(beacon)
                let swing = md - abs(target_y - sensor.y)
                if swing >= 0 {
                    return [((sensor.x - swing), (sensor.x + swing))]
                } else {
                    return []
                }
            }
            ranges.sort(by: { $0.0 < $1.0 })
            
            var idx = 1
            while idx < ranges.count {
                if ranges[idx-1].1 >= ranges[idx].0 {
                    let r = ranges.remove(at: idx)
                    ranges[idx-1].1 = max(ranges[idx-1].1, r.1)
                    continue
                }
                idx += 1
            }
            
            let c = ranges.reduce(0, { $0 + ($1.1 - $1.0 + 1)})
            let e = sbs.map({ $0.1 }).filter({ $0.y == target_y }).uniqued().reduce(0, { acc, _ in acc + 1})
            
            print(c - e)
        }
        
        // part 2
        do {
            for ty in 0...4000000 {
                var ranges = sbs.flatMap { (sensor, beacon) in
                    let md = sensor.md(beacon)
                    let swing = md - abs(ty - sensor.y)
                    if swing >= 0 {
                        return [((sensor.x - swing), (sensor.x + swing))]
                    } else {
                        return []
                    }
                }
                ranges.sort(by: { $0.0 < $1.0 })
                
                var idx = 1
                while idx < ranges.count {
                    if ranges[idx-1].1 >= ranges[idx].0 {
                        let r = ranges.remove(at: idx)
                        ranges[idx-1].1 = max(ranges[idx-1].1, r.1)
                        continue
                    }
                    idx += 1
                }
                
                if ranges.count > 1 {
                    let freq = (ranges[0].1 + 1) * 4000000 + ty
                    print(freq)
                }
            }
        }
    }
}
