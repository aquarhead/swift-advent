import Foundation

internal struct day8 {
    private struct pos: Hashable {
        var x: Int
        var y: Int
    }
    
    internal static func run() {
        var grid : [pos:UInt8] = [:]
        
        day8_input.input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").indexed().forEach { (x,line) in
            line.indexed().forEach { (y, c) in
                grid[pos(x: x, y: y - line.startIndex)] = c.asciiValue! - Character("0").asciiValue!
            }
        }
        
        var visible : Set<pos> = Set.init()
        
        let xmax = grid.keys.map({ $0.x }).max()!
        let ymax = grid.keys.map({ $0.y }).max()!
        
        // part 1
        
        for row in 0...xmax {
            var f_pos = pos(x: row, y: 0)
            var f_height = grid[f_pos]!
            visible.insert(f_pos)
            
            var b_pos = pos(x: row, y: ymax)
            var b_height = grid[b_pos]!
            visible.insert(b_pos)
            
            for _ in 1...(ymax-1) {
                f_pos.y += 1
                if grid[f_pos]! > f_height {
                    f_height = grid[f_pos]!
                    visible.insert(f_pos)
                }
                
                b_pos.y -= 1
                if grid[b_pos]! > b_height {
                    b_height = grid[b_pos]!
                    visible.insert(b_pos)
                }
            }
        }
        
        for col in 0...ymax {
            var f_pos = pos(x: 0, y: col)
            var f_height = grid[f_pos]!
            visible.insert(f_pos)
            
            var b_pos = pos(x: xmax, y: col)
            var b_height = grid[b_pos]!
            visible.insert(b_pos)
            
            for _ in 1...(xmax-1) {
                f_pos.x += 1
                if grid[f_pos]! > f_height {
                    f_height = grid[f_pos]!
                    visible.insert(f_pos)
                }
                
                b_pos.x -= 1
                if grid[b_pos]! > b_height {
                    b_height = grid[b_pos]!
                    visible.insert(b_pos)
                }
            }
        }
        
        print(visible.count)
        
        // part 2
        
        var max_score = 0
        
        for row in 1...xmax-1 {
            for col in 1...ymax-1 {
                
                let cur_h = grid[pos(x: row, y: col)]!
                
                var score = 1
                var sees = 0
                repeat {
                    sees += 1
                } while row-sees > 0 && grid[pos(x: row-sees, y: col)]! < cur_h
                score *= sees
                
                sees = 0
                repeat {
                    sees += 1
                } while row+sees < xmax && grid[pos(x: row+sees, y: col)]! < cur_h
                score *= sees
                
                sees = 0
                repeat {
                    sees += 1
                } while col-sees > 0 && grid[pos(x: row, y: col-sees)]! < cur_h
                score *= sees
                
                sees = 0
                repeat {
                    sees += 1
                } while col+sees < ymax && grid[pos(x: row, y: col+sees)]! < cur_h
                score *= sees
                
                if score > max_score {
                    max_score = score
                }
            }
        }
        
        print(max_score)
    }                    
}
