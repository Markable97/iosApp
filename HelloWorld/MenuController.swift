//
//  ContainerTabBarController.swift
//  Exider.org
//
//  Created by Mark Glushko on 10/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

protocol MenuItem {
    func onClickItem(idDivsion: Int, nameDivision: String)
    func onSwipCloseMenu()
}

class MenuController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    @IBAction func handleSwipClose(_ sender: UISwipeGestureRecognizer) {
        print("SwipClose")
        delegateItem?.onSwipCloseMenu()
    }
    @IBOutlet weak var tableview: UITableView!
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
        delegateItem?.onClickItem(idDivsion: id, nameDivision: name)
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
