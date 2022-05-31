
import UIKit
import CoreData


class PersistantDataController{
    func storeSquareStates(currentBoardStates: GameSquares){
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
    func storePlayerStates(playerScores: TikTokPlayer){
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
    func getSquareStates() -> GameSquares{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BoardState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let boardSquareStates: [Int] = result.value(forKey: "squareStates") as! [Int]
                    let boardState : GameSquares = GameSquares(boardStates: boardSquareStates)
                    return boardState
                }
            }
        } catch {
            print(error)
        }
        return GameSquares(boardStates: [0, 0, 0, 0, 0, 0, 0, 0, 0])
    }
    func getPlayerStates() -> TikTokPlayer{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    let player1_score: Int = result.value(forKey: "firstPlayerScore") as! Int,
                        player2_score: Int = result.value(forKey: "secondPlayerScore") as! Int
                    let playerState : TikTokPlayer = TikTokPlayer(
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
        return TikTokPlayer(player1Score: 0, player2Score: 0)
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
