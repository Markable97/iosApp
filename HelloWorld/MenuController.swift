//
//  ContainerTabBarController.swift
//  Exider.org
//
//  Created by Mark Glushko on 10/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

protocol MenuItem {
    func onClickItem(idDivsion: Int)
}

class MenuController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    var delegateItem: MenuItem?
    let divisions = ["Высший дивизион", "Первый дивизион", "Второй дивизион А", "Второй дивизион В", "Третий дивизион А", "Третий дивизион В"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func onClickItem(id: Int){
        delegateItem?.onClickItem(idDivsion: id)
    }
    
    //MARK: - TABLE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divisions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel!.text = self.divisions[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClickItem(id: indexPath.row+1)
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
