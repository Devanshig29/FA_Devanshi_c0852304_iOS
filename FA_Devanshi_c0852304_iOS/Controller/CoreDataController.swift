//
//  CoreDataController.swift
//  FA_Namrata_C0853345_iOS
//
//  Created by Namrata Barot on 2022-05-30.
//

import UIKit
import CoreData


class CoreDataController{
    func storeSquareStates(currentBoardStates: BoardModel){
        clearBoardStates()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let currentBoardState = NSEntityDescription.insertNewObject(forEntityName: "BoardState", into: context)
        currentBoardState.setValue(currentBoardStates.boardStates, forKey: "squareStates")
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    func storePlayerStates(playerScores: PlayerModel){
        clearPlayerStates()
        print("Player1 scores:", playerScores.player1Score)
        print("Player2 scores:", playerScores.player2Score)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let currentPlayersState = NSEntityDescription.insertNewObject(forEntityName: "PlayerState", into: context)
        currentPlayersState.setValue(playerScores.player1Score, forKey: "firstPlayerScore")
        currentPlayersState.setValue(playerScores.player2Score, forKey: "secondPlayerScore")
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    func getSquareStates() -> BoardModel{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BoardState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let boardSquareStates: [Int] = result.value(forKey: "squareStates") as! [Int]
                    let boardState : BoardModel = BoardModel(boardStates: boardSquareStates)
                    return boardState
                }
            }
        } catch {
            print(error)
        }
        return BoardModel(boardStates: [0, 0, 0, 0, 0, 0, 0, 0, 0])
    }
    func getPlayerStates() -> PlayerModel{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    let player1_score: Int = result.value(forKey: "firstPlayerScore") as! Int,
                        player2_score: Int = result.value(forKey: "secondPlayerScore") as! Int
                    let playerState : PlayerModel = PlayerModel(
                        player1Score: player1_score, player2Score: player2_score
                    )
                    print(" value1 found:",player1_score )
                    print(" value2 found:",player2_score )
                    return playerState
                    
                }
            }
        } catch {
            print(error)
        }
        print("No values found ")
        return PlayerModel(player1Score: 0, player2Score: 0)
    }
    
    func clearBoardStates(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BoardState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                        context.delete(result)
                }
            }
        } catch {
            print(error)
        }
    }
    func clearPlayerStates(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
            }
        } catch {
            print(error)
        }
    }
}
