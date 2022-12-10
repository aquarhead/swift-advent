import Algorithms

internal struct day6 {
    internal static func run() {
        let ws = day6_input.input.windows(ofCount: 4)
        let i = ws.firstIndex(where: {
            return Array($0.uniqued()).count == 4
        })!
        
        print(ws.distance(from: ws.startIndex, to: i) + 4)
        
        let ws2 = day6_input.input.windows(ofCount: 14)
        let i2 = ws2.firstIndex(where: {
            return Array($0.uniqued()).count == 14
        })!
        
        print(ws2.distance(from: ws2.startIndex, to: i2) + 14)
    }
}
