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
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let login = login else { return }
        label.text = "Hello, \(login)"
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
