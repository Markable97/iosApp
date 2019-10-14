//
//  MatchController.swift
//  Exider.org
//
//  Created by Mark Glushko on 12/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class MatchController: UIViewController {

    @IBOutlet weak var divisionUI: UILabel!
    @IBOutlet weak var tourUI: UILabel!
    @IBOutlet weak var scoreUI: UILabel!
    @IBOutlet weak var teamHomeUI: UILabel!
    @IBOutlet weak var teamGuestUI: UILabel!
    @IBOutlet weak var imHomeUI: UIImageView!
    @IBOutlet weak var imGuestUI: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var division: String = ""
    var tour: Int!
    var score: String = ""
    var teamHome: String = ""
    var teamGuest: String = ""
    var imHomeBase64: String = ""
    var imGuestBase64: String = ""
    var idMatch: Int!
    let query = DispatchQueue(label: "ConnectServer", attributes: .concurrent)
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MatchControler vieDidLoad()")
        divisionUI.text = division
        tourUI.text = "Тур " + String(tour)
        scoreUI.text = score
        teamHomeUI.text = teamHome
        teamGuestUI.text = teamGuest
        var decodeData = NSData(base64Encoded: imHomeBase64, options: .ignoreUnknownCharacters)!
        var decodedimage = UIImage(data: decodeData as Data)
        imHomeUI.image = decodedimage
        decodeData = NSData(base64Encoded: imGuestBase64, options: .ignoreUnknownCharacters)!
        decodedimage = UIImage(data: decodeData as Data)
        imGuestUI.image = decodedimage
        indicator.startAnimating()

        group.enter()
        query.async {
            self.sendData(idMatch: self.idMatch)
        }
        

        /*let query = DispatchQueue.global(qos: .utility)
        query.async {
            self.sendData(idMatch: self.idMatch)
        }*/
        // Do any additional setup after loading the view.
    }
    
    func sendData(idMatch: Int){
        print("Send id match = \(idMatch) to server")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: "player", id: idMatch)
        let data = try? encoder.encode(messageForServer)
        let (code,dataFromServer) = Connect().connectionToServer(JSON: data!, time: 4)
        switch code {
            case 1:
                print("seccuss read data from server")
                print("Data from server = \(dataFromServer)")
                self.group.leave()
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    
                }
                
            default:
                print("\(dataFromServer)")
                self.group.leave()
                DispatchQueue.main.async {
                    self.present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
                    self.indicator.stopAnimating()
                    
                }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Жду группу")
        let result = group.wait(timeout: .now()+3)
        switch result {
        case .success:
            print("Succes")
        default:
            print("Дождался")
            dismiss(animated: true, completion: nil)
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
