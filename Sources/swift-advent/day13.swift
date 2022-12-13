struct day13 {
    enum Entry: Equatable {
        case In
        case Out
        case Num(Int)
    }
    
    static func run() {
        func parse(_ line: [Character]) -> [Entry] {
            var list: [Entry] = []
            var cur_num: Int? = nil;
            line.forEach { ch in
                switch ch {
                case "[":
                    list.append(.In)
                case "]":
                    if let n = cur_num {
                        list.append(.Num(n))
                    }
                    list.append(.Out)
                    cur_num = nil
                case ",":
                    if let n = cur_num {
                        list.append(.Num(n))
                    }
                    cur_num = nil
                default:
                    if cur_num == nil {
                        cur_num = 0
                    }
                    cur_num = cur_num! * 10 + Int(ch.asciiValue! - Character("0").asciiValue!)
                }
            }
            return list
        }
        
        func in_order(_ a: [Entry], _ b: [Entry]) -> Bool {
            var left = a
            var right = b
             
            var li = 0
            var ri = 0
            
            while li < left.count {
                switch (left[li], right[ri]) {
                case (.In, .In),
                    (.Out, .Out):
                    li += 1
                    ri += 1
                case (.Num(let ln), .Num(let rn)):
                    if ln < rn {
                        return true
                    }
                    if ln > rn {
                        return false
                    }
                    li += 1
                    ri += 1
                case (.In, .Out),
                    (.Num(_), .Out):
                    return false
                case (.Out, _):
                    return true
                case (.Num(_), .In):
                    left.insert(.Out, at: li+1)
                    left.insert(.In, at: li)
                case (.In, .Num(_)):
                    right.insert(.Out, at: ri+1)
                    right.insert(.In, at: ri)
                }
            }
            
            return true
        }
        
        print(inputs.day13.mine.cleanup().split(separator: "\n\n").map({ $0.split(separator: "\n") }).indexed().filter({
            in_order(parse(Array($1[0])),
                     parse(Array($1[1])))
        }).map({ $0.0 + 1 }).reduce(0, +))
        
        var packets = inputs.day13.mine.cleanup().split(separator: "\n", omittingEmptySubsequences: true).map({ parse(Array($0)) })
        
        let dp1: [Entry] = [.In, .In, .Num(2), .Out, .Out]
        let dp2: [Entry] = [.In, .In, .Num(6), .Out, .Out]
        packets.append(dp1)
        packets.append(dp2)
        
        print(packets.sorted(by: { in_order($0, $1) }).indexed().filter({ $1 == dp1 || $1 == dp2}).map({ $0.0 + 1 }).reduce(1, *))
    }
}
