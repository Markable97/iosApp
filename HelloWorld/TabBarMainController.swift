//
//  TabBarMainController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class TabBarMainController: UITabBarController, UITabBarControllerDelegate {

    var test: String = "Hello from MVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TabBarMainController: ViewDidLoad")
        let query = DispatchQueue.global(qos: .utility)
        query.async {
                self.sendData(logic: "division")
        }
        // Do any additional setup after loading the view.
    }

    func sendForConroler(message: String){
        let first_vc = self.viewControllers?[0] as? ResultController
        first_vc!.recieveTabBarConroler(data: message)
        let seconf_vc = self.viewControllers?[1] as? TournamentTableController
        seconf_vc!.recieveTabBarConroler(data: message)
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
                   DispatchQueue.main.async {
                    self.sendForConroler(message: String(arrayJSON[1]))
                    }
               default:
                   print("\(dataFromServer)")
                   DispatchQueue.main.async {
                        self.sendForConroler(message: "ERROR")
                    }

               }

            //return "prosto tak"
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