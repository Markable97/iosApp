//
//  CalendarController.swift
//  Exider.org
//
//  Created by Mark Glushko on 05/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class CalendarController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction func onClickRefresh(){
        if !rvc.isDownloading{
            indicator.startAnimating()
            
            rvc.controlDownloading()
        
        }else{
            print("Already downloading!!")
        }
    }
    var rvc: TabBarMainController!
    var calendar = [NextMatch]()
    let decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rvc = self.tabBarController as? TabBarMainController  //инициализация род. контролера
        print("CalendarConroler viewDidLoad()")
        indicator.startAnimating()
        // Do any additional setup after loading the view.
    }
    
    //Метод приема от главного контроера
    func recieveTabBarConroler(data: String){
        //print("Данные пришли в Calendar \(data)")
        indicator.stopAnimating()
        if data == "ERROR"{
            present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
        }else{
           //self.textView.text = data
            guard let calendar = try? decoder.decode([NextMatch].self, from: data.data(using: .utf8)!) else {
                print("CalendarConroler bad JSON decode")
                return
            }
            self.calendar = calendar
            tableview.reloadData()
        }
    }

    // MARK: - TABLE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calendar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let calendar = self.calendar[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CalendarCell
        cell.tour.text = "Тур "+String(calendar.idTour!)
        //IMAGE HOME
        if !calendar.imageHome!.isEmpty{
            let decodeData = NSData(base64Encoded: calendar.imageHome!, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: decodeData as Data)
            cell.imaageHome.image = decodedimage
        }
        //IMAGE GUEST
        if !calendar.imageGuest!.isEmpty{
            let decodeData = NSData(base64Encoded: calendar.imageGuest!, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: decodeData as Data)
            cell.imageVisit.image = decodedimage
        }
        cell.teamHome.text = calendar.teamHome!
        cell.teamVisit.text = calendar.teamVisit!
        cell.date.text = calendar.date!
        cell.stadium.text = calendar.nameStadium!
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
