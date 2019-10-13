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
    
    var division: String = ""
    var tour: Int!
    var score: String = ""
    var teamHome: String = ""
    var teamGuest: String = ""
    var imHomeBase64: String = ""
    var imGuestBase64: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
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
