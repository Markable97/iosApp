//
//  ResultController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class ResultController: UIViewController{

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    var test: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ResultConroler: viewDidLoad")
        indicator.startAnimating()
        //reciervFromMVC()
        //print("test = \(test)")
        // Do any additional setup after loading the view.
        /*indicator.startAnimating()
        let query = DispatchQueue.global(qos: .utility)
        query.async {
                self.sendData(logic: "division")
        }*/

        
    }
    
    func recieveTabBarConroler(data: String){
        
        indicator.stopAnimating()
        self.label.text = data
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
