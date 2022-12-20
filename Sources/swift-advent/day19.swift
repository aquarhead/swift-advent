struct day19 {
    struct Resources {
        var ore = 0
        var clay = 0
        var ob = 0
        var geo = 0
    }
    
    struct State {
        var minute = 0
        var res = Resources()
        var bots = Resources()
        
        init() {
            bots.ore = 1
        }
        
        mutating func collect(_ min: Int) {
            minute += min
            res.ore += bots.ore * min
            res.clay += bots.clay * min
            res.ob += bots.ob * min
            res.geo += bots.geo * min
        }
    }
    
    static func run() {
        func calc_min(req: Int, cur: Int, rate: Int) -> Int {
            if cur >= req {
                return 0
            }
            
            var ret = (req - cur) / rate
            if (req - cur) % rate > 0 {
                ret += 1
            }
            return ret
        }
        
        let part1 = inputs.day19.mine.lines().enumerated().map { id, line in
            let nums = Array(line.split(separator: " ").filter({ Array($0)[0].isNumber }))
            let blueprint = nums[1...].map({ Int($0)! })
            
            let partmin = 24
            var this_max = 0
            var geo_bots_possible = Array(repeating: 0, count: partmin)
            var search = [State()]
            
            while search.count > 0 {
                let this_search = search
                search.removeAll()
                for st in this_search {
                    if st.minute == partmin {
                        this_max = max(this_max, st.res.geo)
                        continue
                    }
                    
                    if st.bots.geo > 0 {
                        this_max = max(this_max, st.res.geo + (partmin - st.minute) * st.bots.geo)
                    }
                    
                    if st.bots.geo < geo_bots_possible[st.minute] - 1 {
                        continue
                    }
                    
                    if st.bots.ob > 0 {
                        // try make geo bot
                        var s1 = st
                        let min_wait = max(
                            calc_min(req: blueprint[4], cur: s1.res.ore, rate: s1.bots.ore),
                            calc_min(req: blueprint[5], cur: s1.res.ob, rate: s1.bots.ob)
                        )
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 1 {
                            s1.res.ore -= blueprint[4]
                            s1.res.ob -= blueprint[5]
                            s1.collect(1)
                            s1.bots.geo += 1
                            search.append(s1)
                            if s1.bots.geo > geo_bots_possible[s1.minute] {
                                geo_bots_possible[s1.minute] = s1.bots.geo
                            }
                        }
                    }
                    
                    if st.bots.clay > 0 {
                        // try make ob bot
                        var s1 = st
                        let min_wait = max(
                            calc_min(req: blueprint[2], cur: s1.res.ore, rate: s1.bots.ore),
                            calc_min(req: blueprint[3], cur: s1.res.clay, rate: s1.bots.clay)
                        )
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 2 {
                            s1.res.ore -= blueprint[2]
                            s1.res.clay -= blueprint[3]
                            s1.collect(1)
                            s1.bots.ob += 1
                            search.append(s1)
                        }
                    }
                    
                    do {
                        // try make clay bot
                        var s1 = st
                        let min_wait = calc_min(req: blueprint[1], cur: s1.res.ore, rate: s1.bots.ore)
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 3 {
                            s1.res.ore -= blueprint[1]
                            s1.collect(1)
                            s1.bots.clay += 1
                            search.append(s1)
                        }
                    }
                    
                    do {
                        // try make ore bot
                        var s1 = st
                        let min_wait = calc_min(req: blueprint[0], cur: s1.res.ore, rate: s1.bots.ore)
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 2 {
                            s1.res.ore -= blueprint[0]
                            s1.collect(1)
                            s1.bots.ore += 1
                            search.append(s1)
                        }
                    }
                }
            }
            
            return (id + 1) * this_max
        }.reduce(0, +)
        
        print(part1)
        
        let part2 = inputs.day19.mine.lines()[0...2].map { line in
            let nums = Array(line.split(separator: " ").filter({ Array($0)[0].isNumber }))
            let blueprint = nums[1...].map({ Int($0)! })
            
            let partmin = 32
            var this_max = 0
            var geo_bots_possible = Array(repeating: 0, count: partmin)
            var search = [State()]
            
            while search.count > 0 {
                let this_search = search
                search.removeAll()
                for st in this_search {
                    if st.minute == partmin {
                        this_max = max(this_max, st.res.geo)
                        continue
                    }
                    
                    if st.bots.geo > 0 {
                        this_max = max(this_max, st.res.geo + (partmin - st.minute) * st.bots.geo)
                    }
                    
                    if st.bots.ob > 0 {
                        // try make geo bot
                        var s1 = st
                        let min_wait = max(
                            calc_min(req: blueprint[4], cur: s1.res.ore, rate: s1.bots.ore),
                            calc_min(req: blueprint[5], cur: s1.res.ob, rate: s1.bots.ob)
                        )
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 1 {
                            s1.res.ore -= blueprint[4]
                            s1.res.ob -= blueprint[5]
                            s1.collect(1)
                            s1.bots.geo += 1
                            search.append(s1)
                            if s1.bots.geo > geo_bots_possible[s1.minute] {
                                geo_bots_possible[s1.minute] = s1.bots.geo
                            }
                        }
                    }
                    
                    if geo_bots_possible[0...st.minute].contains(where: { $0 > st.bots.geo}) {
                        continue
                    }
                    
                    if st.bots.clay > 0 {
                        // try make ob bot
                        var s1 = st
                        let min_wait = max(
                            calc_min(req: blueprint[2], cur: s1.res.ore, rate: s1.bots.ore),
                            calc_min(req: blueprint[3], cur: s1.res.clay, rate: s1.bots.clay)
                        )
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 2 {
                            s1.res.ore -= blueprint[2]
                            s1.res.clay -= blueprint[3]
                            s1.collect(1)
                            s1.bots.ob += 1
                            search.append(s1)
                        }
                    }
                    
                    do {
                        // try make clay bot
                        var s1 = st
                        let min_wait = calc_min(req: blueprint[1], cur: s1.res.ore, rate: s1.bots.ore)
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 3 {
                            s1.res.ore -= blueprint[1]
                            s1.collect(1)
                            s1.bots.clay += 1
                            search.append(s1)
                        }
                    }
                    
                    do {
                        // try make ore bot
                        var s1 = st
                        let min_wait = calc_min(req: blueprint[0], cur: s1.res.ore, rate: s1.bots.ore)
                        
                        s1.collect(min_wait)
                        if s1.minute < partmin - 2 {
                            s1.res.ore -= blueprint[0]
                            s1.collect(1)
                            s1.bots.ore += 1
                            search.append(s1)
                        }
                    }
                }
            }
            
            return this_max
        }.reduce(1, *)
        
        print(part2)
    }
}
