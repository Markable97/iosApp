//
//  ResultController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class ResultController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
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
    var results = [PrevMatch]()
    let decoder = JSONDecoder()
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        rvc = self.tabBarController as? TabBarMainController //инициализация род. контролера
        print("ResultConroler: viewDidLoad")
        if rvc.isDownloading{
            indicator.startAnimating()
        }
        
        //textView.text = text
        //reciervFromMVC()
        //print("test = \(test)")
        // Do any additional setup after loading the view.
        /*indicator.startAnimating()
        let query = DispatchQueue.global(qos: .utility)
        query.async {
                self.sendData(logic: "division")
        }*/

        
    }
    
    func recieveTabBarConroler(data: String){
        //print("Данные пришли в Result \(data)")
        if indicator == nil{
            guard let results = try? decoder.decode([PrevMatch].self, from: data.data(using: .utf8)!) else {
                print("ResultConroler bad JSON decoder")
                return
            }
            self.results = results
        }else{
            indicator.stopAnimating()
            //self.textView.text = data
            guard let results = try? decoder.decode([PrevMatch].self, from: data.data(using: .utf8)!) else {
                print("ResultConroler bad JSON decoder")
                return
            }
            self.results = results
            tableview.reloadData()
        }
        
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
