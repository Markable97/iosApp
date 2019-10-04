//
//  MainViewController.swift
//  HelloWorld
//
//  Created by Mark Glushko on 28/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var login: String!
    
    var tournamentTable: [TournamentTable]!
    var prevMatches: [PrevMatch]!
    var nextMatches:[NextMatch]!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let login = login else { return }
        print("Method didLoad Main VC data = \(login)")
        self.sendData(logic: "division")
    }
    
    func sendData(logic: String){
        print("send data to Server with logic \(logic)")
        //let userInfo = UserInfo(email: login!, password: password!)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: logic, id: 1)
        let data = try? encoder.encode(messageForServer)
        print(String(data: data!, encoding: .utf8)!)
        
        //UIApplication.shared.beginIgnoringInteractionEvents()
        let (code,dataFromServer) = Connect().connectionDivision(JSON: data!)
        switch code {
        case 1:
            print("seccuss read data from server")
            //Вытаскивает JSON-ы через ? в строки и конвертируем в Массимы их классов чтобы потом передавать в нужные контроллеры
            let decoder = JSONDecoder()
            let arrayJSON = dataFromServer.split(separator: "?")
            print(arrayJSON)
            let table = try? decoder.decode([TournamentTable].self, from: arrayJSON[0].data(using: .utf8)!)
            print("table = \(table!.count)")
            if arrayJSON[1] != "prevMatch"{
                let prevMatch = try? decoder.decode([PrevMatch].self, from: arrayJSON[1].data(using: .utf8)!)
                print("prev = \(prevMatch!.count)")
            }
            if arrayJSON[2] != "nextMatch"{
                let nextMatch = try? decoder.decode([NextMatch].self, from: arrayJSON[2].data(using: .utf8)!)
                print("next = \(nextMatch!.count)")
            }
            
        default:
            print("\(dataFromServer)")
            present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
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



