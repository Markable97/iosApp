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
    var playersForTable = [PlayerInStatistic]()
    var goalkeepers = [PlayerInStatistic]()
    var defenders = [PlayerInStatistic]()
    var halfbacks = [PlayerInStatistic]()
    var forwards = [PlayerInStatistic]()
    var ussual = [PlayerInStatistic]()
    var cntGoalkeeper: Int = 0
    var cntDefender: Int = 0
    var cntHalfback: Int = 0
    var cntForward: Int = 0
    var cntUssual: Int = 0
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
                    goalkeepers.append(PlayerInStatistic(typeCell: "Cell", player: p))
                    cntGoalkeeper+=1
                case "Защитник":
                    defenders.append(PlayerInStatistic(typeCell: "Cell", player: p))
                    cntDefender+=1
                case "Полузащитник":
                    halfbacks.append(PlayerInStatistic(typeCell: "Cell", player: p))
                    cntHalfback+=1
                case "Нападающий":
                    forwards.append(PlayerInStatistic(typeCell: "Cell", player: p))
                    cntForward+=1
                case "Полевой игрок":
                    ussual.append(PlayerInStatistic(typeCell: "Cell", player: p))
                    cntUssual+=1
                default:
                    break
            }
        }
        playersForTable.append(PlayerInStatistic(typeCell: "Head"))
        if cntGoalkeeper > 0 {
            playersForTable.append(PlayerInStatistic(typeCell: "Amplua", amplua: "Вратарь"))
            playersForTable = playersForTable + goalkeepers
        }
        if cntDefender > 0{
            playersForTable.append(PlayerInStatistic(typeCell: "Amplua", amplua: "Защитник"))
            playersForTable = playersForTable + defenders
        }
        if cntHalfback > 0{
            playersForTable.append(PlayerInStatistic(typeCell: "Amplua", amplua: "Полузащитник"))
            playersForTable = playersForTable + halfbacks
        }
        if cntForward > 0{
            playersForTable.append(PlayerInStatistic(typeCell: "Amplua", amplua: "Нападающий"))
            playersForTable = playersForTable + forwards
        }
        if cntUssual > 0{
            playersForTable.append(PlayerInStatistic(typeCell: "Amplua", amplua: "Полевой игрок"))
            playersForTable = playersForTable + ussual
        }
        
    }
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersForTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        //Ячейка заголовок
        let cellHead = tableView.dequeueReusableCell(withIdentifier: "CellHead") as! HeadCell
        //Ячейка амлуа
        let cellAmplua = tableView.dequeueReusableCell(withIdentifier: "CellAmplua") as! AmpluaCell
        //Ячейка игроков
        let cellPlayer = tableView.dequeueReusableCell(withIdentifier: "CellPlayers") as! HeadCell
        let celling = playersForTable[row]
        switch celling.typeCell {
        case "Head":
            return cellHead
        case "Amplua":
            cellAmplua.amplua.text = celling.amplua
            return cellAmplua
        case "Cell":
            //cellPlayer.number.text = String(row - 1)
            cellPlayer.name.text = celling.player!.nameForTable
            cellPlayer.games.text = String(celling.player!.games)
            cellPlayer.goals.text = String(celling.player!.goal + celling.player!.penalty)
            cellPlayer.assists.text = String(celling.player!.assist)
            cellPlayer.yellowCard.text = String(celling.player!.yellowCard)
            cellPlayer.radCard.text = String(celling.player!.redCard)
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
