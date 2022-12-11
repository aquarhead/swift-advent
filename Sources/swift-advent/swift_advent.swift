@main
public struct swift_advent {
    public static func main() {
        day11.run()
    }
}

extension String {
    func cleanup() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
