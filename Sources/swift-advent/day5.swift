import Foundation
import Algorithms
import RegexBuilder

internal struct day5 {
    internal static func run() {
        let splits = day5.input.split(separator: "\n\n", maxSplits: 2)
        let stacks_strs = splits[0].split(separator: "\n").reversed()
        let proc_strs = splits[1].split(separator: "\n")
        
        let n_stacks = stacks_strs.first!.split(separator: " ", omittingEmptySubsequences: true).map({Int($0)!}).reduce(1, max)
        
        var stacks: [[Character]] = Array(repeating: [], count: n_stacks)
        
        stacks_strs.dropFirst().forEach { line in
            var idx = 0
            line.chunks(ofCount: 4).forEach { crate in
                var ci = crate.makeIterator()
                if ci.next() == "[" {
                    stacks[idx].append(ci.next()!)
                }
                idx += 1
            }
        }
        
        var stacks2 = stacks
        
        let proc_parser = Regex {
            "move "
            Capture { OneOrMore(.digit) }
            " from "
            Capture { OneOrMore(.digit) }
            " to "
            Capture { OneOrMore(.digit) }
        }

        for line in proc_strs {
            if let parsed = try? proc_parser.wholeMatch(in: line) {
                var move_n = Int(parsed.1)!
                let move_from = Int(parsed.2)! - 1
                let move_to = Int(parsed.3)! - 1
                while move_n > 0 {
                    let crate = stacks[move_from].removeLast()
                    stacks[move_to].append(crate)
                    move_n -= 1
                }
            }
        }
        
        print(stacks.map({String($0.last!)}).joined())
        
        for line in proc_strs {
            if let parsed = try? proc_parser.wholeMatch(in: line) {
                var move_n = Int(parsed.1)!
                let move_from = Int(parsed.2)! - 1
                let move_to = Int(parsed.3)! - 1
                var crates : [Character] = []
                while move_n > 0 {
                    crates.append(stacks2[move_from].removeLast())
                    move_n -= 1
                }
                stacks2[move_to].append(contentsOf: crates.reversed())
            }
        }
        
        print(stacks2.map({String($0.last!)}).joined())
    }
    
    static let input_test = """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""
    
    static let input = """
            [G] [W]         [Q]
[Z]         [Q] [M]     [J] [F]
[V]         [V] [S] [F] [N] [R]
[T]         [F] [C] [H] [F] [W] [P]
[B] [L]     [L] [J] [C] [V] [D] [V]
[J] [V] [F] [N] [T] [T] [C] [Z] [W]
[G] [R] [Q] [H] [Q] [W] [Z] [G] [B]
[R] [J] [S] [Z] [R] [S] [D] [L] [J]
 1   2   3   4   5   6   7   8   9

move 6 from 5 to 7
move 2 from 9 to 1
move 4 from 8 to 6
move 1 from 8 to 1
move 2 from 9 to 1
move 1 from 6 to 1
move 13 from 7 to 8
move 1 from 2 to 8
move 9 from 1 to 5
move 1 from 3 to 8
move 3 from 6 to 7
move 4 from 4 to 1
move 11 from 5 to 6
move 6 from 6 to 9
move 3 from 4 to 2
move 7 from 8 to 6
move 1 from 7 to 5
move 1 from 4 to 3
move 7 from 1 to 5
move 2 from 2 to 7
move 4 from 9 to 6
move 1 from 3 to 6
move 1 from 1 to 9
move 1 from 3 to 6
move 1 from 5 to 8
move 4 from 6 to 7
move 3 from 8 to 7
move 7 from 5 to 7
move 1 from 3 to 1
move 1 from 2 to 6
move 14 from 6 to 5
move 2 from 5 to 2
move 3 from 9 to 2
move 6 from 2 to 9
move 7 from 8 to 6
move 7 from 7 to 3
move 2 from 8 to 7
move 6 from 3 to 7
move 17 from 7 to 1
move 1 from 3 to 1
move 1 from 2 to 5
move 4 from 5 to 6
move 17 from 6 to 9
move 7 from 9 to 4
move 1 from 2 to 7
move 2 from 5 to 4
move 3 from 7 to 8
move 7 from 5 to 2
move 6 from 2 to 8
move 8 from 9 to 6
move 1 from 2 to 3
move 8 from 4 to 9
move 7 from 6 to 9
move 18 from 1 to 7
move 1 from 1 to 8
move 2 from 6 to 9
move 1 from 3 to 9
move 1 from 4 to 6
move 1 from 8 to 3
move 1 from 3 to 1
move 10 from 7 to 2
move 9 from 8 to 4
move 1 from 6 to 4
move 2 from 7 to 8
move 5 from 4 to 9
move 17 from 9 to 5
move 2 from 7 to 6
move 5 from 9 to 7
move 5 from 4 to 2
move 8 from 2 to 4
move 8 from 4 to 3
move 2 from 6 to 5
move 2 from 8 to 5
move 3 from 9 to 3
move 4 from 7 to 3
move 6 from 9 to 6
move 4 from 6 to 9
move 5 from 9 to 3
move 8 from 5 to 2
move 1 from 1 to 9
move 1 from 6 to 3
move 1 from 9 to 4
move 5 from 7 to 4
move 19 from 3 to 1
move 4 from 2 to 8
move 13 from 5 to 1
move 1 from 6 to 3
move 3 from 3 to 6
move 2 from 8 to 9
move 4 from 2 to 9
move 2 from 2 to 6
move 1 from 1 to 6
move 5 from 1 to 9
move 10 from 9 to 3
move 15 from 1 to 6
move 21 from 6 to 2
move 20 from 2 to 1
move 2 from 8 to 9
move 28 from 1 to 2
move 6 from 4 to 6
move 2 from 1 to 5
move 3 from 3 to 4
move 2 from 5 to 4
move 1 from 4 to 3
move 3 from 4 to 5
move 2 from 5 to 4
move 1 from 1 to 8
move 25 from 2 to 9
move 1 from 4 to 6
move 1 from 3 to 8
move 4 from 3 to 6
move 1 from 4 to 9
move 2 from 6 to 3
move 1 from 5 to 9
move 5 from 2 to 8
move 7 from 9 to 6
move 2 from 9 to 4
move 3 from 2 to 1
move 3 from 3 to 4
move 1 from 3 to 5
move 16 from 6 to 3
move 7 from 8 to 3
move 5 from 4 to 3
move 1 from 1 to 3
move 1 from 2 to 6
move 1 from 5 to 6
move 21 from 3 to 5
move 2 from 1 to 2
move 1 from 6 to 7
move 10 from 9 to 8
move 1 from 6 to 5
move 5 from 8 to 7
move 12 from 5 to 3
move 20 from 3 to 6
move 4 from 7 to 9
move 1 from 7 to 3
move 1 from 2 to 5
move 1 from 3 to 8
move 2 from 8 to 4
move 4 from 8 to 7
move 3 from 6 to 1
move 1 from 1 to 5
move 2 from 9 to 2
move 2 from 1 to 5
move 2 from 5 to 6
move 3 from 7 to 1
move 2 from 1 to 4
move 4 from 6 to 8
move 3 from 4 to 7
move 3 from 2 to 5
move 2 from 7 to 9
move 9 from 9 to 8
move 1 from 4 to 1
move 7 from 5 to 7
move 1 from 7 to 8
move 1 from 3 to 1
move 4 from 7 to 5
move 2 from 1 to 9
move 1 from 1 to 2
move 5 from 5 to 4
move 1 from 2 to 6
move 5 from 7 to 9
move 5 from 4 to 7
move 11 from 9 to 6
move 14 from 8 to 9
move 23 from 6 to 5
move 6 from 9 to 5
move 1 from 6 to 2
move 10 from 5 to 3
move 1 from 4 to 9
move 1 from 2 to 1
move 2 from 7 to 3
move 10 from 5 to 7
move 8 from 5 to 2
move 5 from 3 to 5
move 7 from 5 to 8
move 1 from 2 to 7
move 9 from 7 to 9
move 3 from 2 to 3
move 2 from 6 to 2
move 2 from 3 to 6
move 4 from 7 to 5
move 1 from 1 to 5
move 4 from 3 to 1
move 2 from 5 to 2
move 1 from 3 to 2
move 2 from 6 to 8
move 7 from 5 to 3
move 9 from 2 to 4
move 2 from 1 to 2
move 2 from 5 to 3
move 1 from 4 to 9
move 1 from 6 to 9
move 1 from 4 to 2
move 2 from 1 to 7
move 3 from 2 to 6
move 4 from 8 to 7
move 2 from 8 to 3
move 2 from 3 to 7
move 1 from 6 to 5
move 2 from 8 to 2
move 5 from 4 to 1
move 8 from 9 to 8
move 1 from 5 to 7
move 10 from 9 to 2
move 8 from 8 to 2
move 1 from 1 to 6
move 12 from 3 to 9
move 7 from 7 to 4
move 13 from 2 to 4
move 7 from 2 to 7
move 1 from 6 to 7
move 3 from 9 to 8
move 2 from 6 to 3
move 1 from 3 to 2
move 1 from 3 to 9
move 3 from 1 to 5
move 1 from 1 to 6
move 4 from 7 to 6
move 5 from 7 to 1
move 1 from 2 to 1
move 6 from 9 to 4
move 5 from 9 to 7
move 3 from 8 to 3
move 22 from 4 to 9
move 24 from 9 to 8
move 1 from 9 to 2
move 2 from 4 to 3
move 10 from 8 to 3
move 1 from 2 to 1
move 1 from 3 to 8
move 1 from 6 to 3
move 1 from 1 to 4
move 4 from 3 to 4
move 4 from 6 to 1
move 2 from 4 to 5
move 4 from 7 to 2
move 7 from 4 to 6
move 4 from 6 to 1
move 2 from 6 to 3
move 1 from 6 to 2
move 5 from 5 to 2
move 12 from 3 to 5
move 3 from 7 to 8
move 6 from 2 to 3
move 11 from 1 to 9
move 1 from 1 to 7
move 1 from 7 to 5
move 2 from 3 to 9
move 2 from 9 to 7
move 4 from 2 to 5
move 2 from 7 to 1
move 17 from 8 to 1
move 1 from 3 to 2
move 16 from 1 to 3
move 8 from 3 to 4
move 2 from 8 to 3
move 2 from 1 to 5
move 1 from 2 to 6
move 12 from 5 to 8
move 1 from 6 to 3
move 9 from 3 to 9
move 8 from 4 to 6
move 2 from 1 to 6
move 6 from 8 to 4
move 3 from 4 to 6
move 1 from 1 to 9
move 11 from 6 to 8
move 3 from 4 to 3
move 17 from 9 to 5
move 2 from 6 to 7
move 1 from 9 to 1
move 2 from 8 to 6
move 1 from 7 to 5
move 1 from 8 to 9
move 1 from 1 to 7
move 3 from 9 to 6
move 2 from 7 to 8
move 1 from 9 to 6
move 15 from 5 to 2
move 9 from 3 to 9
move 11 from 8 to 3
move 6 from 9 to 8
move 4 from 6 to 7
move 3 from 3 to 7
move 5 from 5 to 6
move 7 from 7 to 5
move 3 from 6 to 1
move 2 from 1 to 4
move 1 from 9 to 2
move 2 from 9 to 3
move 2 from 6 to 3
move 1 from 1 to 8
move 6 from 5 to 9
move 8 from 2 to 5
move 10 from 8 to 5
move 1 from 2 to 9
move 21 from 5 to 9
move 2 from 8 to 4
move 5 from 9 to 1
move 2 from 5 to 2
move 15 from 9 to 2
move 1 from 5 to 9
move 9 from 9 to 3
move 1 from 1 to 6
move 3 from 4 to 1
move 20 from 3 to 5
move 20 from 5 to 4
move 7 from 4 to 3
move 1 from 1 to 7
move 11 from 4 to 5
move 4 from 3 to 2
move 11 from 5 to 4
move 2 from 6 to 7
move 4 from 3 to 9
move 2 from 2 to 8
move 2 from 9 to 4
move 6 from 4 to 6
move 2 from 7 to 9
move 1 from 7 to 6
move 1 from 4 to 9
move 4 from 4 to 6
move 2 from 8 to 6
move 1 from 4 to 3
move 1 from 4 to 6
move 1 from 3 to 1
move 3 from 4 to 3
move 9 from 2 to 8
move 2 from 3 to 7
move 5 from 6 to 2
move 2 from 7 to 5
move 1 from 5 to 2
move 1 from 9 to 3
move 1 from 5 to 1
move 13 from 2 to 5
move 4 from 9 to 5
move 1 from 3 to 4
move 9 from 2 to 3
move 7 from 3 to 2
move 11 from 5 to 6
move 5 from 8 to 7
move 1 from 3 to 1
move 2 from 8 to 5
move 2 from 8 to 1
move 1 from 4 to 1
move 6 from 2 to 7
move 3 from 5 to 3
move 1 from 2 to 5
move 7 from 7 to 9
move 3 from 3 to 5
move 1 from 2 to 5
move 2 from 3 to 2
move 6 from 1 to 7
move 10 from 7 to 3
move 1 from 2 to 3
move 6 from 9 to 8
move 1 from 2 to 4
move 2 from 6 to 1
move 5 from 1 to 9
move 8 from 5 to 8
move 2 from 1 to 6
move 6 from 3 to 4
move 1 from 5 to 3
move 4 from 9 to 6
move 1 from 1 to 4
move 2 from 9 to 2
move 5 from 6 to 1
move 11 from 6 to 7
move 1 from 2 to 8
move 6 from 7 to 5
move 10 from 8 to 4
move 2 from 3 to 9
move 3 from 3 to 5
move 4 from 7 to 9
move 2 from 1 to 3
move 10 from 5 to 8
move 6 from 6 to 1
move 2 from 6 to 8
move 2 from 9 to 5
move 4 from 9 to 6
move 7 from 4 to 8
move 5 from 6 to 1
move 4 from 8 to 2
move 2 from 5 to 6
move 5 from 4 to 5
move 1 from 7 to 5
move 2 from 3 to 6
move 1 from 3 to 8
move 4 from 6 to 1
move 4 from 2 to 3
move 5 from 5 to 1
move 2 from 3 to 2
move 2 from 3 to 2
move 20 from 8 to 2
move 5 from 4 to 8
move 1 from 4 to 3
move 8 from 2 to 1
move 1 from 5 to 6
move 5 from 2 to 3
move 1 from 6 to 5
move 5 from 3 to 2
move 1 from 3 to 7
move 6 from 8 to 5
move 13 from 2 to 9
move 7 from 9 to 8
move 1 from 7 to 8
move 5 from 8 to 3
move 2 from 2 to 5
move 2 from 8 to 4
move 27 from 1 to 5
move 1 from 2 to 3
move 5 from 3 to 1
move 22 from 5 to 7
move 1 from 8 to 5
move 1 from 3 to 2
move 7 from 1 to 3
move 2 from 3 to 7
move 2 from 2 to 4
move 5 from 9 to 1
move 5 from 3 to 9
move 3 from 1 to 5
move 3 from 1 to 6
move 3 from 6 to 3
move 4 from 4 to 2
move 8 from 5 to 3
move 8 from 7 to 4
move 14 from 7 to 4
move 1 from 1 to 7
move 6 from 9 to 6
move 7 from 5 to 3
move 14 from 3 to 6
move 2 from 2 to 1
move 4 from 3 to 7
move 6 from 7 to 6
move 1 from 7 to 6
move 1 from 5 to 1
move 2 from 1 to 5
move 3 from 5 to 7
move 8 from 6 to 5
move 5 from 5 to 1
move 1 from 7 to 3
move 1 from 3 to 8
move 22 from 4 to 7
move 7 from 6 to 3
move 4 from 3 to 2
move 3 from 1 to 3
move 17 from 7 to 6
move 1 from 8 to 1
move 2 from 2 to 4
move 3 from 7 to 2
move 2 from 2 to 9
move 1 from 1 to 8
move 2 from 3 to 1
move 6 from 6 to 8
move 2 from 9 to 2
move 4 from 5 to 1
move 5 from 8 to 9
move 1 from 7 to 3
move 4 from 3 to 4
move 1 from 7 to 4
move 4 from 9 to 7
move 5 from 7 to 9
move 1 from 7 to 3
move 2 from 2 to 8
move 5 from 4 to 2
move 21 from 6 to 8
move 2 from 3 to 8
move 23 from 8 to 6
move 1 from 2 to 6
move 2 from 9 to 8
move 22 from 6 to 7
move 2 from 9 to 3
move 2 from 3 to 7
move 2 from 1 to 6
move 1 from 2 to 5
move 3 from 1 to 3
move 6 from 7 to 4
move 5 from 8 to 5
move 1 from 3 to 8
move 1 from 9 to 3
move 6 from 4 to 8
move 1 from 5 to 3
move 6 from 2 to 8
move 15 from 7 to 5
move 1 from 7 to 1
move 14 from 5 to 8
move 1 from 4 to 9
move 5 from 1 to 7
move 3 from 6 to 2
move 4 from 5 to 6
move 1 from 4 to 8
move 4 from 3 to 1
move 2 from 9 to 2
move 7 from 7 to 1
move 7 from 2 to 7
move 9 from 8 to 6
move 7 from 7 to 1
move 12 from 6 to 8
move 25 from 8 to 6
move 3 from 8 to 1
move 28 from 6 to 2
move 15 from 2 to 3
move 1 from 5 to 4
move 3 from 2 to 7
move 6 from 2 to 9
"""
}
