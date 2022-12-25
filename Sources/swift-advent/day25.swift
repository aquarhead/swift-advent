struct day25 {
    static func run() {
        print(Snafu(decimal: inputs.day25.mine.lines().map({ Int(snafu: Snafu($0)) }).reduce(0, +)))
    }
}

struct Snafu {
    var value: Int
    
    init(decimal: Int) {
        value = decimal
    }
    
    init(_ snafu: String) {
        value = snafu.reversed().reduce(into: (1, 0)) { acc, ch in
            switch ch {
            case "=":
                acc.1 -= acc.0 * 2
            case "-":
                acc.1 -= acc.0
            default:
                acc.1 += acc.0 * Int(ch.asciiValue! - Character("0").asciiValue!)
            }
            acc.0 *= 5
        }.1
        
    }
}

extension Int {
    init(snafu: Snafu) {
        self = snafu.value
    }
}

extension Snafu: CustomStringConvertible {
    var description: String {
        var b5 = Array(String(self.value, radix: 5).reversed())
        var carry: UInt8 = 0
        var ret: [String] = []
        
        while b5.count > 0 {
            let x = b5.removeFirst().asciiValue! - Character("0").asciiValue! + carry
            carry = 0
            
            switch x {
            case 5:
                ret.append("0")
                carry = 1
            case 4:
                ret.append("-")
                carry = 1
            case 3:
                ret.append("=")
                carry = 1
            default:
                ret.append(String(x))
            }
        }
        
        if carry > 0 {
            ret.append("1")
        }
        
        return ret.reversed().joined()
    }
}
