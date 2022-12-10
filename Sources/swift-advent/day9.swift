import Foundation
import RegexBuilder

internal struct day9 {
    private struct pos: Hashable {
        var x: Int
        var y: Int
    }
    
    internal static func run() {
        var visited1: Set<pos> = [pos(x: 0, y: 0)]
        var visited : Set<pos> = [pos(x: 0, y: 0)]
        
        let parser = Regex {
            Capture { .word }
            " "
            Capture { OneOrMore(.digit) }
        }
        
        var rope = Array(repeating: pos(x: 0, y: 0), count: 10)
        
        day9_input.input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").forEach { move in
            let m = try? parser.wholeMatch(in: move)
            let dir = m!.1
            var steps = Int(m!.2)!
            while steps > 0 {
                switch dir {
                case "U":
                    rope[0].y -= 1
                case "D":
                    rope[0].y += 1
                case "L":
                    rope[0].x -= 1
                case "R":
                    rope[0].x += 1
                default:
                    print("shouldn't be here")
                }
                
                for idx in 1..<10 {
                    let xdiff = abs(rope[idx].x - rope[idx-1].x)
                    let ydiff = abs(rope[idx].y - rope[idx-1].y)

                    if xdiff > 1 || ydiff > 1 {
                        if rope[idx-1].y > rope[idx].y {
                            rope[idx].y += 1
                        } else if rope[idx-1].y < rope[idx].y {
                            rope[idx].y -= 1
                        }
                        
                        if rope[idx-1].x > rope[idx].x {
                            rope[idx].x += 1
                        } else if rope[idx-1].x < rope[idx].x {
                            rope[idx].x -= 1
                        }
                    }
                }
                
                visited1.insert(rope[1])
                visited.insert(rope[9])
                steps -= 1
            }
        }

        print(visited1.count)
        print(visited.count)
    }
}
