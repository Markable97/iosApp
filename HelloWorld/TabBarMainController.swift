//
//  TabBarMainController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

protocol MenuDelegate{
    func toggleMenu()
}

class TabBarMainController: UITabBarController{
    
    var first_vc: CalendarController!
    var seconf_vc: ResultController!
    var third_vc: TournamentTableController!
    
    var mainControler: UIViewController!
    
    var test: String = "Hello from MVC"
    var idDivision: Int = 1
    var isDownloading: Bool = false
    var delegateMenu: MenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        first_vc = self.viewControllers?[0].children[0] as? CalendarController
        seconf_vc = self.viewControllers?[1].children[0] as? ResultController
        third_vc = self.viewControllers?[2].children[0] as? TournamentTableController
        print("TabBarMainController: ViewDidLoad")
        let query = DispatchQueue.global(qos: .utility)
        query.async {
                self.sendData(logic: "division")
        }
        // Do any additional setup after loading the view.
    }

    func toggleMenu(){
        delegateMenu?.toggleMenu()
    }
    
    func sendForConroler(message: String){
        isDownloading = false
        //var arrayJSON = [String.SubSequence()]
        /*let first_vc = self.viewControllers?[0].children[0] as? CalendarController
        let seconf_vc = self.viewControllers?[1].children[0] as? ResultController
        let third_vc = self.viewControllers?[2].children[0] as? TournamentTableController*/
        if message != "ERROR"{
            //Вытаскивает JSON-ы через ? в строки и передаем в табы
            let arrayJSON = message.split(separator: "?")
            //print(arrayJSON)
            let table: String = String(arrayJSON[0])
            let prevMatch: String = String(arrayJSON[1])
            let nextMatch: String = String(arrayJSON[2])
            first_vc!.recieveTabBarConroler(data: nextMatch)
            seconf_vc!.recieveTabBarConroler(data: prevMatch)
            third_vc!.recieveTabBarConroler(data: table)
        }else{
            first_vc!.recieveTabBarConroler(data: message)
            seconf_vc!.recieveTabBarConroler(data: message)
            third_vc!.recieveTabBarConroler(data: message)
        }

    }
    
    func startAllIndicator(titleName: String){
        first_vc!.navigationItem.title  = titleName
        first_vc!.indicator.startAnimating()
        seconf_vc!.navigationItem.title  = titleName
        seconf_vc!.indicator.startAnimating()
        third_vc!.navigationItem.title  = titleName
        third_vc!.indicator.startAnimating()
    }
    func startAllIndicator(){
        first_vc!.indicator.startAnimating()
        seconf_vc!.indicator.startAnimating()
        third_vc!.indicator.startAnimating()
    }
    
    func controlDownloading(){
        if !isDownloading{
            startAllIndicator()
            let query = DispatchQueue.global(qos: .utility)
            query.async {
                    self.sendData(logic: "division")
            }
        }else{
            print("Downloding exist!!!!!")
        }
    }
    
    func sendData(logic: String){
           print("send data to Server with logic \(logic)")
        if !isDownloading{
           isDownloading = true
           //let userInfo = UserInfo(email: login!, password: password!)
           let encoder = JSONEncoder()
           encoder.outputFormatting = .prettyPrinted
            let messageForServer = MessageJSON(messageLogic: logic, id: self.idDivision)
           let data = try? encoder.encode(messageForServer)
           //print(String(data: data!, encoding: .utf8)!)
           //UIApplication.shared.beginIgnoringInteractionEvents()
           let (code,dataFromServer) = Connect().connectionToServer(JSON: data!)
               switch code {
               case 1:
                   print("seccuss read data from server")
                   DispatchQueue.main.async {
                    self.sendForConroler(message: dataFromServer)
                    }
               default:
                   print("\(dataFromServer)")
                   DispatchQueue.main.async {
                        self.sendForConroler(message: "ERROR")
                    }

               }
        }else{
            print("donwloding exist")
        }
            //return "prosto tak"
       }
    //возврат от главного контейнера о закрытии меню
    func close() {
        print("Return from main container about close menu")
        first_vc!.closeMenu()
        seconf_vc!.closeMenu()
        third_vc!.closeMenu()
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
