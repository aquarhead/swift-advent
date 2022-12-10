internal struct day1 {
    internal static func run() {
        let carry = day1_input.input.split(separator: "\n\n").map({$0.split(separator: "\n").map({Int($0)!}).reduce(0, {$0 + $1})})

        print(carry.max()!)
        print(carry.sorted().reversed()[0 ..< 3].reduce(0, {$0 + $1}))
    }
}
