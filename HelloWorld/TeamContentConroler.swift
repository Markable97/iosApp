//
//  TeamContentConroler.swift
//  Exider.org
//
//  Created by Mark Glushko on 18/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit
import DLRadioButton

class TeamContentConroler: UIViewController {

    @IBOutlet weak var teamNameUI: UILabel!
    @IBOutlet weak var btntPlayers: DLRadioButton!
    @IBOutlet weak var btnMatches: DLRadioButton!
    @IBOutlet weak var imageTeam: UIImageView!
    
    var teamName: String = ""
    var imageBase64: String = ""
    var downVC: DownContentController!
    
    @IBAction func onClickStatPlayer(_ sender: DLRadioButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            print("Click first")
            btnMatches.isSelected = false
            downVC.showOtherConroler(move: false)
        }
    }
    
    @IBAction func onClickAllMatches(_ sender: DLRadioButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            print("Click second")
            btntPlayers.isSelected = false
            downVC.showOtherConroler(move: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downVC = self.children[0] as! DownContentController
        btnMatches.isMultipleSelectionEnabled = true
        btntPlayers.isMultipleSelectionEnabled = true
        btntPlayers.isSelected = true
        teamNameUI.text = teamName
        if !imageBase64.isEmpty{
            let decodeData = NSData(base64Encoded: imageBase64, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: decodeData as Data)
            imageTeam.image = decodedimage
        }
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
