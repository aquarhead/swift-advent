import RegexBuilder

fileprivate struct Monkey {
    var items: [Int]
    
    enum OpTyp {
        case Add
        case Mul
    }
    
    enum OpTarget {
        case Num(Int)
        case Old
    }
    
    let op: (OpTyp, OpTarget)
    let test: (Int, Array.Index, Array.Index)
    
    init(from: String) {
        let lines = Array(from.split(separator: "\n"))
                        
        items = lines[1][lines[1].index(lines[1].startIndex, offsetBy: "  Starting items: ".count)...].split(separator: ", ").map({ Int($0)! })
        
        let op_t : OpTyp
        if let _ = lines[2].firstIndex(of: "+") {
            op_t = OpTyp.Add
        } else {
            op_t = OpTyp.Mul
        }
        if let op_n = Int(lines[2][lines[2].index(lines[2].lastIndex(of: " ")!, offsetBy: 1)...]) {
            op = (op_t, .Num(op_n))
        } else {
            op = (op_t, .Old)
        }
        
        test = (
            Int(lines[3][lines[3].index(lines[3].lastIndex(of: " ")!, offsetBy: 1)...])!,
            Int(lines[4][lines[4].index(lines[4].lastIndex(of: " ")!, offsetBy: 1)...])!,
            Int(lines[5][lines[5].index(lines[5].lastIndex(of: " ")!, offsetBy: 1)...])!
        )
    }
    
    var inspected = 0
    
    mutating func turn() -> [Array.Index:[Int]] {
        var ret: [Array.Index:[Int]] = [test.1 : [], test.2 : []]
        
        inspected += items.count
        
        items.map({
            switch op {
            case (.Add, .Num(let n)):
                return $0 + n
            case (.Mul, .Num(let n)):
                return $0 * n
            case (.Add, .Old):
                return $0 + $0
            case (.Mul, .Old):
                return $0 * $0
            }
        }).map({ $0 / 3 }).forEach({
            if $0 % test.0 == 0 {
                ret[test.1]!.append($0)
            } else {
                ret[test.2]!.append($0)
            }
        })
        
        items = []
        
        return ret
    }
        
    mutating func turn2(_ lim: Int) -> [Array.Index:[Int]] {
        var ret: [Array.Index:[Int]] = [test.1 : [], test.2 : []]
        
        inspected += items.count
        
        items.map({
            switch op {
            case (.Add, .Num(let n)):
                return $0 + n
            case (.Mul, .Num(let n)):
                return $0 * n
            case (.Add, .Old):
                return $0 + $0
            case (.Mul, .Old):
                return $0 * $0
            }
        }).map({ $0 % lim }).forEach({
            if $0 % test.0 == 0 {
                ret[test.1]!.append($0)
            } else {
                ret[test.2]!.append($0)
            }
        })
        
        items = []
        
        return ret
    }
}

internal struct day11 {
    internal static func run() {
        var monkeys = inputs.day11.mine.cleanup().split(separator: "\n\n").map({ Monkey(from: String($0)) })
        var monkeys2 = monkeys
        
        var round = 1
        while round <= 20 {
            for idx in 0..<(monkeys.count) {
                monkeys[idx].turn().forEach { (target, throwed) in
                    monkeys[target].items += throwed
                }
            }
            round += 1
        }
        
        print(monkeys.map({ $0.inspected }).max(count: 2).reduce(1, *))
        
        let lim = monkeys2.reduce(1, { $0 * $1.test.0 })
        var round2 = 1
        while round2 <= 10000 {
            for idx in 0..<(monkeys2.count) {
                monkeys2[idx].turn2(lim).forEach { (target, throwed) in
                    monkeys2[target].items += throwed
                }
            }
            round2 += 1
        }
        
        print(monkeys2.map({ $0.inspected }).max(count: 2).reduce(1, *))
    }
}
