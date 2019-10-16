//
//  MatchController.swift
//  Exider.org
//
//  Created by Mark Glushko on 12/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class MatchController: UIViewController {

    @IBOutlet weak var divisionUI: UILabel!
    @IBOutlet weak var tourUI: UILabel!
    @IBOutlet weak var scoreUI: UILabel!
    @IBOutlet weak var teamHomeUI: UILabel!
    @IBOutlet weak var teamGuestUI: UILabel!
    @IBOutlet weak var imHomeUI: UIImageView!
    @IBOutlet weak var imGuestUI: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    //all players from server
    var players = [Player]()
    var playersHome = [PlayerInMatch]()
    var playersGuest = [PlayerInMatch]()
    
    var firstOpen: Bool = true
    var division: String = ""
    var tour: Int!
    var score: String = ""
    var teamHome: String = ""
    var teamGuest: String = ""
    var imHomeBase64: String = ""
    var imGuestBase64: String = ""
    var idMatch: Int!
    let query = DispatchQueue(label: "ConnectServer", attributes: .concurrent)
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MatchControler vieDidLoad()")
        divisionUI.text = division
        tourUI.text = "Тур " + String(tour)
        scoreUI.text = score
        teamHomeUI.text = teamHome
        teamGuestUI.text = teamGuest
        var decodeData = NSData(base64Encoded: imHomeBase64, options: .ignoreUnknownCharacters)!
        var decodedimage = UIImage(data: decodeData as Data)
        imHomeUI.image = decodedimage
        decodeData = NSData(base64Encoded: imGuestBase64, options: .ignoreUnknownCharacters)!
        decodedimage = UIImage(data: decodeData as Data)
        imGuestUI.image = decodedimage
        indicator.startAnimating()

        group.enter()
        query.async {
            self.sendData(idMatch: self.idMatch)
        }
        /*let query = DispatchQueue.global(qos: .utility)
        query.async {
            self.sendData(idMatch: self.idMatch)
        }*/
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewWillApperar")
        print("Жду группку")
        group.wait()
        print("Дождался группу")
        if self.players.count > 0 && firstOpen{
            sortPlayers()
            firstOpen = false
        }
    }
    func sendData(idMatch: Int){
        print("Send id match = \(idMatch) to server")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: "player", id: idMatch)
        let data = try? encoder.encode(messageForServer)
        let (code,dataFromServer) = Connect().connectionToServer(JSON: data!, time: 2)
        switch code {
            case 1:
                print("seccuss read data from server")
                print("Data from server = \(dataFromServer)")
                let decoder = JSONDecoder()
                guard let players = try? decoder.decode([Player].self, from: dataFromServer.data(using: .utf8)!) else {
                    print("Bad decoding to JSON")
                    self.group.leave()
                    return
                }
                self.players = players
                print("Count players with statistic \(self.players.count)")
                self.group.leave()
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }

            default:
                print("\(dataFromServer)")
                self.group.leave()
                DispatchQueue.main.async {
                    self.present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
                    self.indicator.stopAnimating()
                    
                }
        }
    }
    
    func sortPlayers(){
        var assistHome: String = ""
        var assistGuest: String = ""
        for p in self.players{
            if p.playerTeam == teamHome{
                if p.goal > 0 {
                    playersHome.append(PlayerInMatch(action: "goal", name: p.playerName, countAction: p.goal))
                }
                if p.assist > 0{
                    let str = p.playerName.split(separator: " ")
                    let name = str[0] + " " + str[1]
                    if assistHome.count == 0{
                         assistHome = name + "("+String(p.assist)+")"
                    }else{
                        assistHome += ", " + name + " ("+String(p.assist)+")"
                    }
                }
                if p.own_goal > 0{
                    playersHome.append(PlayerInMatch(action: "own_goal", name: p.playerName, countAction: p.own_goal))
                }
                if p.penalty > 0{
                    playersHome.append(PlayerInMatch(action: "penalty", name: p.playerName, countAction: p.penalty))
                }
                if p.penalty_out > 0 {
                    playersHome.append(PlayerInMatch(action: "penalty_out", name: p.playerName, countAction: p.penalty_out))
                }
                if p.redCard > 0 {
                    playersHome.append(PlayerInMatch(action: "red", name: p.playerName, countAction: p.redCard))
                }
                if p.yellowCard == 1{
                    playersHome.append(PlayerInMatch(action: "yellow", name: p.playerName, countAction: p.yellowCard))
                }else if p.yellowCard == 2{
                    playersHome.append(PlayerInMatch(action: "yellow_red", name: p.playerName, countAction: p.yellowCard))
                }
            }else{
                if p.goal > 0 {
                    playersGuest.append(PlayerInMatch(action: "goal", name: p.playerName, countAction: p.goal))
                }
                if p.assist > 0{
                    let str = p.playerName.split(separator: " ")
                    let name = str[0] + " " + str[1]
                    if assistGuest.count == 0{
                         assistGuest = name + "(" + String(p.assist) + ")"
                    }else{
                        assistGuest += ", " + name + " ("+String(p.assist)+")"
                    }
                }
                if p.own_goal > 0{
                    playersGuest.append(PlayerInMatch(action: "own_goal", name: p.playerName, countAction: p.own_goal))
                }
                if p.penalty > 0{
                    playersGuest.append(PlayerInMatch(action: "penalty", name: p.playerName, countAction: p.penalty))
                }
                if p.penalty_out > 0 {
                    playersGuest.append(PlayerInMatch(action: "penalty_out", name: p.playerName, countAction: p.penalty_out))
                }
                if p.redCard > 0 {
                    playersGuest.append(PlayerInMatch(action: "red", name: p.playerName, countAction: p.redCard))
                }
                if p.yellowCard == 1{
                    playersGuest.append(PlayerInMatch(action: "yellow", name: p.playerName, countAction: p.yellowCard))
                }else if p.yellowCard == 2{
                    playersGuest.append(PlayerInMatch(action: "yellow_red", name: p.playerName, countAction: p.yellowCard))
                }
            }
        }
        playersHome.append(PlayerInMatch(action: "assist", name: assistHome, countAction: 0))
        playersGuest.append(PlayerInMatch(action: "assist", name: assistGuest, countAction: 0))
        print("Home players \(playersHome.count)")
        print("Guest players \(playersGuest.count)")
        let homeTable = self.children[0] as! HomeTeamController
        let guestTable = self.children[1] as! GuestTeamController
        homeTable.dataFromMatchConroler(data: playersHome)
        guestTable.dataFromMatchConroler(data: playersGuest)
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        print("Жду группу")
        let result = group.wait(timeout: .now()+3)
        switch result {
        case .success:
            print("Succes")
        default:
            print("Дождался")
            dismiss(animated: true, completion: nil)
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
