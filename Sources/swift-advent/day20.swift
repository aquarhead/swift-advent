struct day20 {
    static func run() {
        let enc1 = inputs.day20.mine.lines().enumerated().map({ ($0, Int($1)!) })
        let len = enc1.count
        
        // part 1
        do {
            var enc = enc1
            for t in 0..<len {
                var idx = enc.firstIndex(where: { $0.0 == t })!
                let nb = enc.remove(at: idx)
                
                idx += nb.1
                idx %= (len - 1)
                
                if idx < 0 {
                    idx = len - 1 + idx
                }
                
                enc.insert(nb, at: idx)
            }
            
            let dec = enc.map({ $0.1 })
            
            let zi = dec.firstIndex(where: { $0 == 0 })!
            print(dec[(zi + 1000) % len] + dec[(zi + 2000) % len] + dec[(zi + 3000) % len])
        }
        
        // part 2
        do {
            var enc = enc1.map({ ($0.0, $0.1 * 811589153) })
            
            for _ in 0..<10 {
                for t in 0..<len {
                    var idx = enc.firstIndex(where: { $0.0 == t })!
                    let nb = enc.remove(at: idx)
                    
                    idx += nb.1
                    idx %= (len - 1)
                    
                    if idx < 0 {
                        idx = len - 1 + idx
                    }
                    
                    enc.insert(nb, at: idx)
                }
            }
            
            let dec = enc.map({ $0.1 })
            
            let zi = dec.firstIndex(where: { $0 == 0})!
            print(dec[(zi + 1000) % len] + dec[(zi + 2000) % len] + dec[(zi + 3000) % len])
        }
    }
}
