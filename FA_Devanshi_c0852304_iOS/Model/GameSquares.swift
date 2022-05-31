
import Foundation
import UIKit
class GameSquares{
    var board: [UIButton] = [UIButton]()
    var boardStates: [Int]
    init(boardStates: [Int]){
        self.boardStates = boardStates
    }
    
    func add(square: UIButton){
        board.append(square)
    }
}

