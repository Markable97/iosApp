//
//  MatchesController.swift
//  Exider.org
//
//  Created by Mark Glushko on 19/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class MatchesController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var results = [PrevMatch]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Matches VC did load")
        // Do any additional setup after loading the view.
    }
    
    func sendFromDownVC(data: String){
        print("This MatchesVC \(data.count)")
        let decoder = JSONDecoder()
        guard let results = try? decoder.decode([PrevMatch].self, from: data.data(using: .utf8)!) else {
            print("ResultConroler bad JSON decoder")
            return
        }
        self.results = results
        self.tableview.reloadData()
    }
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ResultCell
        let result: PrevMatch = self.results[row]
        cell.tour.text = "Тур " + String(result.idTour!)
        //IMAGE HOME
        if !result.imageHome!.isEmpty{
            let decodeData = NSData(base64Encoded: result.imageHome!, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: decodeData as Data)
            cell.imaageHome.image = decodedimage
        }
        //IMAGE GUEST
        if !result.imageGuest!.isEmpty{
            let decodeData = NSData(base64Encoded: result.imageGuest!, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: decodeData as Data)
            cell.imageVisit.image = decodedimage
        }

        cell.teamHome.text = result.teamHome!
        cell.teamVisit.text = result.teamVisit!
        cell.goalHome.text = String(result.goalHome!)
        cell.goalVisit.text = String(result.goalVisit!)
        
        return cell
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MatchDetail"{
            if let indexPath = self.tableview.indexPathForSelectedRow{
                let matchDetail = segue.destination as! MatchController
                matchDetail.division = results[indexPath.row].nameDivision!
                matchDetail.tour = results[indexPath.row].idTour!
                let goalHome = results[indexPath.row].goalHome!
                let goalGuest = results[indexPath.row].goalVisit!
                matchDetail.score = String(goalHome) + " : " + String(goalGuest)
                matchDetail.teamHome = results[indexPath.row].teamHome!
                matchDetail.teamGuest = results[indexPath.row].teamVisit!
                matchDetail.imHomeBase64 = results[indexPath.row].imageHome!
                matchDetail.imGuestBase64 = results[indexPath.row].imageGuest!
                matchDetail.idMatch = results[indexPath.row].id_match!
            }
        }
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
