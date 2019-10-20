//
//  StatisticController.swift
//  Exider.org
//
//  Created by Mark Glushko on 19/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class StatisticController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var players = [Player]()
    
    var cntGoalkeeper: Int = 0
    var cntDefender: Int = 0
    var cntHalfback: Int = 0
    var cntForward: Int = 0
    var numberPlayer: Int = 0
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Statistic did load")
        // Do any additional setup after loading the view.
    }
    
    func sendFromDownVC(data: String){
        print("This StaticticVC \(data.count)")
        let decoder = JSONDecoder()
        guard let players = try? decoder.decode([Player].self, from: data.data(using: .utf8)!) else {
            print("Bad decoding to JSON")
            return
        }
        self.players = players
        print("Count players = \(self.players.count)")
        sortPlayers()
        tableview.reloadData()
    }

    func sortPlayers(){
        for p in self.players{
            switch p.amplua {
                case "Вратарь":
                    cntGoalkeeper+=1
                case "Защитник":
                    cntDefender+=1
                case "Полузащитник":
                    cntHalfback+=1
                case "Нападающий":
                    cntForward+=1
                default:
                    break
            }
        }
    }
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count + 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == self.players.count{
            self.numberPlayer = 0
        }
        //Ячейка заголовок
        let cellHead = tableView.dequeueReusableCell(withIdentifier: "CellHead") as! HeadCell
        //Ячейка амлуа
        let cellAmplua = tableView.dequeueReusableCell(withIdentifier: "CellAmplua") as! AmpluaCell
        //Ячейка игроков
        let cellPlayer = tableView.dequeueReusableCell(withIdentifier: "CellPlayers") as! HeadCell
        switch row {
        case 0:
            return cellHead
        case 1:
            cellAmplua.amplua.text = "Вратарь"
            return cellAmplua
        case 2..<cntGoalkeeper+2: //2 до 2 + 3
            let goalkeeper = self.players[self.numberPlayer]
            cellPlayer.number.text = String(self.numberPlayer + 1)
            cellPlayer.name.text = goalkeeper.nameForTable
            cellPlayer.games.text = String(goalkeeper.games)
            cellPlayer.goals.text = String(goalkeeper.goal + goalkeeper.penalty)
            cellPlayer.assists.text = String(goalkeeper.assist)
            cellPlayer.yellowCard.text = String(goalkeeper.yellowCard)
            cellPlayer.radCard.text = String(goalkeeper.redCard)
            self.numberPlayer+=1
            return cellPlayer
        case cntGoalkeeper+2..<cntGoalkeeper+3:
            cellAmplua.amplua.text = "Защитник"
            return cellAmplua
        case cntGoalkeeper+3..<cntGoalkeeper + cntDefender + 3:
            let defender = self.players[self.numberPlayer]
            cellPlayer.number.text = String(self.numberPlayer + 1)
            cellPlayer.name.text = defender.nameForTable
            cellPlayer.games.text = String(defender.games)
            cellPlayer.goals.text = String(defender.goal + defender.penalty)
            cellPlayer.assists.text = String(defender.assist)
            cellPlayer.yellowCard.text = String(defender.yellowCard)
            cellPlayer.radCard.text = String(defender.redCard)
            self.numberPlayer+=1
            return cellPlayer
        case cntGoalkeeper + cntDefender + 3..<cntGoalkeeper + cntDefender + 4:
            cellAmplua.amplua.text = "Полузащитник"
            return cellAmplua
        case cntGoalkeeper + cntDefender + 4..<cntGoalkeeper + cntDefender + cntHalfback + 4:
            let halfback = self.players[self.numberPlayer]
            cellPlayer.number.text = String(self.numberPlayer + 1)
            cellPlayer.name.text = halfback.nameForTable
            cellPlayer.games.text = String(halfback.games)
            cellPlayer.goals.text = String(halfback.goal + halfback.penalty)
            cellPlayer.assists.text = String(halfback.assist)
            cellPlayer.yellowCard.text = String(halfback.yellowCard)
            cellPlayer.radCard.text = String(halfback.redCard)
            self.numberPlayer+=1
            return cellPlayer
        case cntGoalkeeper + cntDefender + cntHalfback + 4..<cntGoalkeeper + cntDefender + cntHalfback + 5:
            cellAmplua.amplua.text = "Нападающий"
            return cellAmplua
        case cntGoalkeeper + cntDefender + cntHalfback + 5..<cntGoalkeeper + cntDefender + cntHalfback + cntForward + 5:
            let forward = self.players[self.numberPlayer]
            cellPlayer.number.text = String(self.numberPlayer + 1)
            cellPlayer.name.text = forward.nameForTable
            cellPlayer.games.text = String(forward.games)
            cellPlayer.goals.text = String(forward.goal + forward.penalty)
            cellPlayer.assists.text = String(forward.assist)
            cellPlayer.yellowCard.text = String(forward.yellowCard)
            cellPlayer.radCard.text = String(forward.redCard)
            self.numberPlayer+=1
            return cellPlayer
        default:
            break
        }
        return cellHead
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
