//
//  TabBarMainController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

protocol MenuDelegate{
    func toggleMenu(divisionsJSON: String)
}

class TabBarMainController: UITabBarController{
    
    var first_vc: CalendarController!
    var seconf_vc: ResultController!
    var third_vc: TournamentTableController!
    
    var mainControler: UIViewController!
    
    var divisionsJSON: String!
    var firstSetup: Bool = true
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
        delegateMenu?.toggleMenu(divisionsJSON: divisionsJSON)
    }
    
    func sendForConroler(message: String){
        isDownloading = false
        if firstSetup{
            let decoder = JSONDecoder()
            guard let divisions = try? decoder.decode([Division].self, from: divisionsJSON.data(using: .utf8)!) else {
                setAllTitle(titleName: "Дивизион")
                print("Divisions bad JSON decode")
                return
            }
            setAllTitle(titleName: divisions[0].nameDivision)
        }
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
    func setAllTitle(titleName: String){
        
            first_vc!.navigationItem.title  = titleName
        
        
            seconf_vc!.navigationItem.title  = titleName
        
        
            third_vc!.navigationItem.title  = titleName
        
    }
    func startAllIndicator(titleName: String){
        firstSetup = false
        first_vc!.navigationItem.title  = titleName
        first_vc!.indicator.startAnimating()
        seconf_vc!.navigationItem.title  = titleName
        seconf_vc!.indicator.startAnimating()
        third_vc!.navigationItem.title  = titleName
        third_vc!.indicator.startAnimating()
    }
    func startAllIndicator(){
        if first_vc!.indicator != nil{
            first_vc!.indicator.startAnimating()
        }
        if seconf_vc!.indicator != nil{
            seconf_vc!.indicator.startAnimating()
        }
        if third_vc!.indicator != nil{
            third_vc!.indicator.startAnimating()
        }
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
            var error = true
            var (isSend,JSON) = sendDopData(idDivision: self.idDivision, logic: "listDivision")
            self.divisionsJSON = JSON
            error = isSend
            print("Logic 1 download = \(error)")
            (isSend, JSON) = sendDopData(idDivision: self.idDivision, logic: logic)
            let dataFromServer = JSON
            error = isSend
            print("Logic 2 download = \(error)")
            if (error){
                print("seccuss read data from server")
                DispatchQueue.main.async {
                 self.sendForConroler(message: dataFromServer)
                 }
            }else{
                print("Error in SendData")
                DispatchQueue.main.async {
                     self.sendForConroler(message: "ERROR")
                }
            }
        }else{
            print("donwloding exist")
        }
            //return "prosto tak"
       }
    func sendDopData(idDivision: Int, logic: String)->(Bool,String){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: logic, id: idDivision)
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
               print("ERROR in logic = \(logic)")
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
