import Foundation
import RegexBuilder

internal struct day7 {
    enum Content {
        case subDir(String)
        case file(Int)
    }
    
    internal static func run() {
        var contents: [String: [Content]] = [:]
        var sizes: [String: Int] = [:]
        
        let cd_parser = Regex {
            "cd "
            Capture { OneOrMore(.any) }
        }
        
        let ls_parser = Regex {
            Capture {
                ChoiceOf {
                    "dir"
                    OneOrMore(.digit)
                }
            }
            " "
            Capture { OneOrMore(.any) }
        }
        
        var current_dir = ""
        
        day7_input.input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "$ ").forEach { cmd in
            let lines = cmd.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n")

            if let m = try? cd_parser.wholeMatch(in: lines[0]) {
                if m.1.hasPrefix("/") {
                    current_dir = String(m.1)
                } else if m.1 == ".." {
                    while current_dir.popLast() != "/" {}
                } else {
                    current_dir += "/" + m.1
                }
            } else {
                contents[current_dir] = lines[1...].map({
                    let m = try? ls_parser.wholeMatch(in: $0)
                    if m!.1 == "dir" {
                       return Content.subDir(String(m!.2))
                    }
                    else {
                       return Content.file(Int(m!.1)!)
                    }
                })
            }
        }
        
        contents.keys.sorted().reversed().forEach { key in
            sizes[key] = contents[key]?.reduce(0, { acc, c in
                switch c {
                case let .subDir(d): return acc + sizes[key + "/" + d]!
                case let .file(s): return acc + s
                }
            })
        }
        
        print(sizes.values.filter({ $0 <= 100000 }).reduce(0, +))
        
        let needed = 30000000 - (70000000 - sizes["/"]!)
        print(sizes.values.sorted().first(where: { $0 >= needed })!)
    }
}
