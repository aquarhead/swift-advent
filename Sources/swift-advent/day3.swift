import Foundation
import Algorithms

internal struct day3 {
    internal static func run() {
        let elves = day3_input.input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n")

        print(elves.map({
            let str = String($0)
            let mid = str.index(str.startIndex, offsetBy: str.count / 2)
            let first = str.prefix(upTo: mid)
            let second = str.suffix(from: mid)

            for c in first {
                if second.contains(c) {
                    if c.isUppercase {
                        return UInt32(c.asciiValue! - Character("A").asciiValue! + 27)
                    }
                    else {
                       return UInt32(c.asciiValue! - Character("a").asciiValue! + 1)
                    }
                }
            }

            return 0
        }).reduce(0, +))

        print(elves.chunks(ofCount: 3).map({
            let i = $0.startIndex
            for c in $0[i] {
                if $0[i+1].contains(c) && $0[i+2].contains(c) {
                    if c.isUppercase {
                        return UInt32(c.asciiValue! - Character("A").asciiValue! + 27)
                    }
                    else {
                       return UInt32(c.asciiValue! - Character("a").asciiValue! + 1)
                    }
                }
            }
            return 0
        }).reduce(0, +))
    }
}
