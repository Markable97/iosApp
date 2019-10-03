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
        let messageForServer = TestJson(logic: logic, id: 1)
        let data = try? encoder.encode(messageForServer)
        print(String(data: data!, encoding: .utf8)!)
        
        //UIApplication.shared.beginIgnoringInteractionEvents()
        if(Connect().connectionDivision(JSON: data!)){
            //indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            print("seccuss")
        }else{
            //indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            print("ERROR")
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

class TestJson: Codable{
    var messageLogic: String
    var id: Int
    
    init(logic: String, id: Int){
        self.messageLogic = logic
        self.id = id
    }
}


