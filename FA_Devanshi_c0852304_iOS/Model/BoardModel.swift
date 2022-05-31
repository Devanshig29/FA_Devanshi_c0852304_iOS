//
//  Board.swift
//  FA_Namrata_C0853345_iOS
//
//  Created by Namrata Barot on 2022-05-30.
//

import Foundation
import UIKit
class BoardModel{
    var board: [UIButton] = [UIButton]()
    var boardStates: [Int]
    init(boardStates: [Int]){
        self.boardStates = boardStates
    }
    
    func add(square: UIButton){
        board.append(square)
    }
}

