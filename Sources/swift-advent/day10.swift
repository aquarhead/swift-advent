fileprivate struct cpu {
    var x = 1
    var cycle = 1
    var crt = ""
    
    static let ct = [20, 60, 100, 140, 180, 220]
    var sum = 0
    
    private mutating func adv() {
        if cpu.ct.contains(self.cycle) {
            self.sum += self.cycle * self.x
        }
        let pos = (self.cycle - 1) % 40
        if abs(pos - self.x) <= 1 {
            self.crt += "#"
        } else {
            self.crt += "."
        }
        if pos == 39 {
            self.crt += "\n"
        }
        self.cycle += 1
    }
    
    mutating func addx(n: Int) {
        self.adv()
        self.adv()
        self.x += n
    }
    
    mutating func noop() {
        self.adv()
    }
}

internal struct day10 {
    internal static func run() {
        var x = cpu()
      
        inputs.day10.input.cleanup().split(separator: "\n").forEach { line in
            let s = line.split(separator: " ")
            if s.count > 1 {
                x.addx(n: Int(s[1])!)
            } else {
                x.noop()
            }
        }
        
        print(x.sum)
        print(x.crt)
    }
}
