import Foundation

internal struct day4 {
    internal static func run() {
        let pairs = day4_input.input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").map({
            $0.split(separator: ",").map({ parse(range: String($0)) })
        })
        
        print(pairs.filter({
            return ($0[0].0 >= $0[1].0 && $0[0].1 <= $0[1].1) || ($0[1].0 >= $0[0].0 && $0[1].1 <= $0[0].1)
        }).count)
        
        print(pairs.filter({
            return ($0[0].0...$0[0].1).overlaps($0[1].0...$0[1].1)
        }).count)
    }
    
    private static func parse(range: String) -> (Int, Int) {
        let s = range.split(separator: "-")
        return (Int(s[0])!, Int(s[1])!)
    }
}
