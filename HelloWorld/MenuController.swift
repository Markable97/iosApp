//
//  ContainerTabBarController.swift
//  Exider.org
//
//  Created by Mark Glushko on 10/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit
import Dropper
protocol MenuItem {
    func onClickItem(idDivsion: Int, nameDivision: String)
    func onSwipCloseMenu()
}

class MenuController: UIViewController,  UITableViewDataSource, UITableViewDelegate, DropperDelegate {

    @IBAction func handleSwipClose(_ sender: UISwipeGestureRecognizer) {
        print("SwipClose")
        dropper.hideWithAnimation(0.1)
        delegateItem?.onSwipCloseMenu()
    }
    @IBOutlet weak var tableview: UITableView!
    
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        print("Нажата кнопка \(contents)")
        let (isSend,JSON) = sendDopData(nameLeague: contents, logic: "listDivision")
        if isSend {
            dropdownButton.setTitle(contents, for: .normal)
            nameLeague = contents
            refresh(data: JSON)
        }else{
            present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
        }
    }
    var nameLeague: String = ""
     var dropper = Dropper(width: 200, height: 100)
    @IBOutlet var dropdownButton: UIButton!
    @IBAction func DropdownAction() {
        print("Нажата кнопка выбора лиг ")
        
        if dropper.status == .hidden {
            dropper = Dropper(width: 200, height: 100)
            dropper.items = ["Восточная Лига", "Западная Лига", "Северная Лига"] // Item displayed
            
            dropper.theme = Dropper.Themes.black(nil)
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.center, position: .top, button: dropdownButton)
            //dropdownButton.titleLabel?.text = nameLeague
        } else {
            dropper.hideWithAnimation(0.1)
            //dropdownButton.titleLabel?.text = nameLeague
        }
    }
    var delegateItem: MenuItem?
    /*let divisions = ["Высший дивизион", "Первый дивизион", "Второй дивизион А", "Второй дивизион В", "Третий дивизион А", "Третий дивизион В"]*/
    
    var divisions = [Division]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MenuControler viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    func refresh(data: String){
        print("recieve divisionsJSON")
        let decoder = JSONDecoder()
        guard let divisions = try? decoder.decode([Division].self, from: data.data(using: .utf8)!) else {
            self.divisions = []
            tableview.reloadData()
            print("Divisions bad JSON decode")
            return
        }
        self.divisions = divisions
        tableview.reloadData()
    }
    
    func onClickItem(id: Int, name: String){
        dropper.hideWithAnimation(0.1)
        delegateItem?.onClickItem(idDivsion: id, nameDivision: name)
    }
    //MARK: - CONNECT
    func sendDopData(nameLeague: String, logic: String)->(Bool,String){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: logic, name_league: nameLeague)
        messageForServer.name_league = nameLeague
        let data = try? encoder.encode(messageForServer)
        let connect = Connect()
        let connection = connect.openConnect()
        if connection{
            let (code,dataFromServer) = connect.connectToServer(JSON: data!)
            switch code {
            case 1:
                print("seccuss read data from server")
              
                return (true, dataFromServer)
                
            default:
               print("ERROR in logic = \(logic)")
               return(false,"ERROR")
            }
        
        }else{
            return (false,"ERROR")
        }
    }
    //MARK: - TABLE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divisions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel!.text = self.divisions[indexPath.row].nameDivision
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClickItem(id: divisions[indexPath.row].idDivision, name: divisions[indexPath.row].nameDivision)
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
