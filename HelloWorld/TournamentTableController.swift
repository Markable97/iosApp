//
//  TournamentTableController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class TournamentTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var isMove = false //для меню
    var tournamentTable = [TournamentTable]()
    let decoder = JSONDecoder()
    var text: String = "Default"
    
    let green = UIColor(rgb: 0xe4f7e3)
    let red = UIColor(rgb: 0xffd5cf)
    let yellow = UIColor(rgb: 0xfeffdb)
    let white = UIColor.white
    
    @IBAction func handleSwip(_ sender: UISwipeGestureRecognizer) {
        if !isMove{
            print("SWIP SWIP SWIP")
            self.view.alpha = 0.6
            isMove = true
            rvc.toggleMenu()
        }
    }
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
    @IBAction func onClickMenu(){
        self.view.alpha = 0.6
        rvc.toggleMenu()
    }
    func closeMenu(){
        isMove = false
        self.view.alpha = 1
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
                self.tournamentTable = []
                self.tableview.reloadData()
                print("TableConroler bad JSON decode")
                return
            }
            self.tournamentTable = tournamentTable
            self.tableview.reloadData()
            //let table = try? decoder.decode([TournamentTable].self, from: arrayJSON[0].data(using: .utf8)!)
        }
        
    }
    func getColorCell(nameDivision: String, position: Int) -> UIColor{
        var color: UIColor
        switch nameDivision {
        case "Высший дивизион":
            if position  < 7 {
                color = green
            }else{
                color = red
            }
        case "Первый дивизион":
            if position < 4 {
                color = green
            }else if position == 4 || position == 5 {
                color = yellow
            }else if position > 15 {
                color = red
            }else{
                color = white
            }
        case "Второй дивизион A", "Второй дивизион B":
            if position < 4{
                color = green
            }else if position > 17{
                color = red
            }else {
                color = white
            }
        case "Третий дивизион A", "Третий дивизион B":
            if position < 2{
                color = green
            }else{
                color = white
            }
        default:
            color = white
        }
        return color
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
            cell.backgroundColor = getColorCell(nameDivision: tournamentTable.divisionName!, position: row)
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
    
    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row > 0 {
            performSegue(withIdentifier: "TeamContent", sender: nil)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableview.indexPathForSelectedRow{
            let row = indexPath.row - 1
            if segue.identifier == "TeamContent"{
                 let teamContent =  segue.destination as! TeamContentConroler
                 teamContent.teamName = self.tournamentTable[row].teamName!
                 teamContent.imageBase64 = self.tournamentTable[row].imageBase64!
            }
        }
    }

}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
