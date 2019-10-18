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
    
    @IBAction func onClickStatPlayer(_ sender: DLRadioButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            print("Click first")
            teamNameUI.text = "First"
            btnMatches.isSelected = false
        }
        

    }
    
    @IBAction func onClickAllMatches(_ sender: DLRadioButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            print("Click second")
            teamNameUI.text = "Second"
            btntPlayers.isSelected = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMatches.isMultipleSelectionEnabled = true
        btntPlayers.isMultipleSelectionEnabled = true
        btntPlayers.isSelected = true
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
