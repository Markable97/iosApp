//
//  ContainerTabBarController.swift
//  Exider.org
//
//  Created by Mark Glushko on 10/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class MenuController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    let divisions = ["Высший дивизион", "Первый дивизион", "Второй дивизион А", "Второй дивизион В", "Третий дивизион А", "Третий дивизион В"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
