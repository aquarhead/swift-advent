struct day21 {
    enum Monkey {
        case Op(String, String, String)
        case Num(Int)
    }
    
    static func run() {
        let monkeys0: [String:Monkey] = inputs.day21.mine.lines().reduce(into: [:], { acc, line in
            let x = line.split(separator: ": ")
            let key = x[0]
            if let n = Int(x[1]) {
                acc[String(key)] = .Num(n)
            } else {
                let m = x[1].split(separator: " ")
                acc[String(key)] = .Op(String(m[0]), String(m[1]), String(m[2]))
            }
        })
        
        // part 1
        do {
            var monkeys = monkeys0
        outer: while true {
            for (mk, mv) in monkeys {
                if case .Op(let k1, let ops, let k2) = mv {
                    if case .Num(let v1) = monkeys[k1]! {
                        if case .Num(let v2) = monkeys[k2]! {
                            switch ops {
                            case "+":
                                monkeys[mk] = .Num(v1 + v2)
                            case "-":
                                monkeys[mk] = .Num(v1 - v2)
                            case "*":
                                monkeys[mk] = .Num(v1 * v2)
                            default:
                                monkeys[mk] = .Num(v1 / v2)
                            }
                            continue outer
                        }
                    }
                }
            }
            
            break
        }
            
            print(monkeys["root"]!)
        }
        
        // part 2
        do {
            var monkeys = monkeys0
            
            var backfill = ["humn"]
        backfill: while true {
            for (mk, mv) in monkeys {
                if case .Op(let k1, _, let k2) = mv {
                    if k1 == backfill.last || k2 == backfill.last {
                        backfill.append(mk)
                        continue backfill
                    }
                }
            }
            
            break
        }
            
        outer: while true {
            for (mk, mv) in monkeys {
                if !backfill.contains(mk) {
                    if case .Op(let k1, let ops, let k2) = mv {
                        if case .Num(let v1) = monkeys[k1]! {
                            if case .Num(let v2) = monkeys[k2]! {
                                switch ops {
                                case "+":
                                    monkeys[mk] = .Num(v1 + v2)
                                case "-":
                                    monkeys[mk] = .Num(v1 - v2)
                                case "*":
                                    monkeys[mk] = .Num(v1 * v2)
                                default:
                                    monkeys[mk] = .Num(v1 / v2)
                                }
                                continue outer
                            }
                        }
                    }
                }
            }
            
            break
        }
            
            backfill.removeLast()
            var ev = one_value("root").0
            func one_value(_ key: String) -> (Int, Bool) {
                if case .Op(let k1, _, let k2) = monkeys[key] {
                    if k1 != "humn" {
                        if case .Num(let v1) = monkeys[k1]! {
                            return (v1, true)
                        }
                    }
                    
                    if case .Num(let v2) = monkeys[k2]! {
                        return (v2, false)
                    }
                }
                
                return (-1, false)
            }
            for k in backfill[1...].reversed() {
                if case .Op(_, let ops, _) = monkeys[k] {
                    let ov = one_value(k)
                    switch ops {
                    case "+":
                        ev = ev - ov.0
                    case "-":
                        if ov.1 {
                            // ov - new_ev == ev
                            ev = ov.0 - ev
                        } else {
                            // new_ev - ov == ev
                            ev = ov.0 + ev
                        }
                    case "*":
                        ev = ev / ov.0
                    default:
                        if ov.1 {
                            // ov / new_ev == ev
                            ev = ov.0 / ev
                        } else {
                            // new_ev / ov == ev
                            ev = ov.0 * ev
                        }
                    }
                }
            }
            
            print(ev)
        }
    }
}
