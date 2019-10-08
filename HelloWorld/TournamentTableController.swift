//
//  TournamentTableController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class TournamentTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tournamentTable = [TournamentTable]()
    let decoder = JSONDecoder()
    var text: String = "Default"
    
    //@IBOutlet weak var textView: UITextView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func onClickRefresh(){
        if !rvc.isDownloading{
            //textView.text = "TEEEEEEST"
            indicator.startAnimating()
            
            rvc.controlDownloading()
        
        }else{
            print("Already downloading!!")
        }
    }
    var rvc: TabBarMainController!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        rvc = self.tabBarController as? TabBarMainController //инициализация род. контролера
        print("Tournament table viewDidLoad()")
        if rvc.isDownloading{
            indicator.startAnimating()
        }
        
        //textView.text = text
        //print(tournamentTable.count)
        //fromMainConriler()

        // Do any additional setup after loading the view.
    }

     func recieveTabBarConroler(data: String){
        //print("Данные пришли в TournamentTable \(data)")
        if indicator == nil{
            guard let tournamentTable = try? decoder.decode([TournamentTable].self, from: data.data(using: .utf8)!) else {
            print("TableConroler bad JSON decode")
            return
            }
            self.tournamentTable = tournamentTable
        }else{
            indicator.stopAnimating()
            guard let tournamentTable = try? decoder.decode([TournamentTable].self, from: data.data(using: .utf8)!) else {
                print("TableConroler bad JSON decode")
                return
            }
            self.tournamentTable = tournamentTable
            self.tableview.reloadData()
            //let table = try? decoder.decode([TournamentTable].self, from: arrayJSON[0].data(using: .utf8)!)
        }
        
    }

    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tournamentTable.count+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 30
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TournamentCell
        if indexPath.row == 0{
            cell.position.text = "#"
            cell.imageTeam.image = nil
            cell.teamName.text = "Команда"
            cell.games.text = "И"
            cell.scored.text = "З"
            cell.conceded.text = "П"
            cell.points.text = "О"
        }else{
            let row = indexPath.row-1
            let tournamentTable: TournamentTable = self.tournamentTable[row]
            cell.position.text = String(row+1)
            //загрузка картинку
            if !tournamentTable.imageBase64!.isEmpty{
                let decodeData = NSData(base64Encoded: tournamentTable.imageBase64!, options: .ignoreUnknownCharacters)!
                let decodedimage = UIImage(data: decodeData as Data)
                cell.imageTeam.image = decodedimage
            }
            cell.teamName.text = tournamentTable.teamName!
            cell.games.text = String(tournamentTable.games!)
            cell.scored.text = String(tournamentTable.goalScored!)
            cell.conceded.text = String(tournamentTable.goalConceded!)
            cell.points.text = String(tournamentTable.points!)
        }
        
        
        
        return cell
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
