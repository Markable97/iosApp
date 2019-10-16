//
//  GuestTeamController.swift
//  Exider.org
//
//  Created by Mark Glushko on 15/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class GuestTeamController: UITableViewController {

    var players = [PlayerInMatch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GuestTeam viewDidLoad")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func dataFromMatchConroler(data: [PlayerInMatch]){
        print("Hello from MatchConroler in Guest")
        self.players = data
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if players[indexPath.row].action == "assist" && players[indexPath.row].name.count > 0 {
            return 100
        }else{
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlayerInMatchCell
        switch players[row].action {
        case "goal":
            cell.actionView?.image = UIImage(named: "goal")
            cell.name?.text = players[row].nameForTable + "(\(players[row].countAction!))"
        case "own_goal":
            cell.actionView?.image = UIImage(named: "own_goal")
            cell.name?.text = players[row].nameForTable + "(\(players[row].countAction!))"
        case "penalty":
            cell.actionView?.image = UIImage(named: "penalty")
            cell.name?.text = players[row].nameForTable + "(\(players[row].countAction!))"
        case "penalty_out":
            cell.name?.text = players[row].nameForTable + "(\(players[row].countAction!)"
            cell.actionView?.image = UIImage(named: "penalty_out")
        case "yellow":
            cell.name?.text = players[row].nameForTable
            cell.actionView?.image = UIImage(named: "yellow_card")
        case "red":
            cell.name?.text = players[row].nameForTable
            cell.actionView?.image = UIImage(named: "red_card")
        case "yellow_red":
            cell.name?.text = players[row].nameForTable
            cell.actionView?.image = UIImage(named: "red_yellow_card")
        case "assist":
            cell.name?.text = "Ассистенты: " + players[row].name
            //cell.name?.textAlignment = NSTextAlignment.left
        default: break
        }
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
