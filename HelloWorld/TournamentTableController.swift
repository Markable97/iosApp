//
//  TournamentTableController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class TournamentTableController: UIViewController {

    //var tournamentTable: [TournamentTable]!
    
    var text: String = "While Empty"
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Tournament table viewDidLoad()")
        textView.text = text
        //print(tournamentTable.count)
        //fromMainConriler()

        // Do any additional setup after loading the view.
    }

     func recieveTabBarConroler(data: String){
        if textView == nil{
            
            self.text = data
        }else{
            self.textView.text = data
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