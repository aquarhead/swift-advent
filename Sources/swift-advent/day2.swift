import Foundation

internal struct day2 {
    internal static func run() {
        print(day2_input.input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").map({
            let result: Int
            switch String($0) {
            case "A X", "B Y", "C Z":
                result = 3
            case "A Y", "B Z", "C X":
                result = 6
            default:
                result = 0
            }

            let hand : Int
            switch $0.last {
            case "X":
               hand = 1
            case "Y":
               hand = 2
            default:
               hand = 3
            }
            return result + hand
        }).reduce(0, +))

        print(day2_input.input.split(separator: "\n").map({
            let result: Int
            switch $0.last {
            case "X":
                result = 0
            case "Y":
                result = 3
            default:
                result = 6
            }

            let hand : Int
            switch String($0) {
            case "A Y", "B X", "C Z":
               hand = 1
            case "B Y", "A Z", "C X":
               hand = 2
            default:
               hand = 3
            }
            return result + hand
        }).reduce(0, +))
    }
}
