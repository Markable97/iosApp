//
//  TeamContentConroler.swift
//  Exider.org
//
//  Created by Mark Glushko on 18/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit
import DLRadioButton

class TeamContentConroler: UIViewController {

    @IBOutlet weak var teamNameUI: UILabel!
    @IBOutlet weak var btntPlayers: DLRadioButton!
    @IBOutlet weak var btnMatches: DLRadioButton!
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var players: String!
    var results: String!
    var teamName: String = ""
    var imageBase64: String = ""
    var idTeam: Int!
    var downVC: DownContentController!
    let decoder = JSONDecoder()
    
    @IBAction func onClickStatPlayer(_ sender: DLRadioButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            print("Click first")
            btnMatches.isSelected = false
            downVC.showOtherConroler(move: false)
        }
    }
    
    @IBAction func onClickAllMatches(_ sender: DLRadioButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            print("Click second")
            btntPlayers.isSelected = false
            downVC.showOtherConroler(move: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downVC = self.children[0] as? DownContentController
        btnMatches.isMultipleSelectionEnabled = true
        btntPlayers.isMultipleSelectionEnabled = true
        btntPlayers.isSelected = true
        teamNameUI.text = teamName
        if !imageBase64.isEmpty{
            let decodeData = NSData(base64Encoded: imageBase64, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: decodeData as Data)
            imageTeam.image = decodedimage
        }
        indicator.startAnimating()
        let query = DispatchQueue.global(qos: .utility)
         query.async {
            self.sendMainData(idTeam: self.idTeam)
         }
        // Do any additional setup after loading the view.
    }
    
    func sendMainData(idTeam: Int){
        print("send data to Server \(idTeam)")
        var error = true
        var (isSend,JSON) = sendDopData(idTeam: idTeam, logic: "team")
        self.players = JSON
        error = isSend
        (isSend, JSON) = sendDopData(idTeam: idTeam, logic: "matches")
        self.results = JSON
        error = isSend
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.downVC.sendFromTeamVC(players:self.players, results:self.results)
            if(!error){
                self.present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
            }
        }
    }

    func sendDopData(idTeam: Int, logic: String)->(Bool,String){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: logic, id: self.idTeam)
        let data = try? encoder.encode(messageForServer)
        let connect = Connect()
        let connection = connect.openConnect()
        if connection{
            let (code,dataFromServer) = connect.connectToServer(JSON: data!)
            switch code {
            case 1:
                print("seccuss read data from server")
                //print("Data from server = \(dataFromServer)")
                return (true, dataFromServer)
                /*guard let players = try? decoder.decode([Player].self, from: dataFromServer.data(using: .utf8)!) else {
                    print("Bad decoding to JSON")
                }*/
            default:
               print("\(dataFromServer)")
               return(false,"ERROR")
            }
            /*DispatchQueue.main.async {
                self.indicator.stopAnimating()
                if code != 1{
                    self.present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
                }
            }*/
        }else{
            return (false,"ERROR")
            /*DispatchQueue.main.async {
            self.indicator.stopAnimating()
                self.present(AlertVisible.showAlert(message: "Не удалось поделючиться к серверу данных"), animated: true, completion: nil)
            }*/
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
