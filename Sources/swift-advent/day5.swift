import Foundation
import Algorithms
import RegexBuilder

internal struct day5 {
    internal static func run() {
        let splits = day5_input.input.split(separator: "\n\n", maxSplits: 2)
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
}
