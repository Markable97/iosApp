//
//  TournamentTableController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class TournamentTableController: UIViewController {

    var tournamentTable: [TournamentTable]!
    let decoder = JSONDecoder()
    var text: String = ""
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction func onClickRefresh(){
        if !rvc.isDownloading{
            textView.text = "TEEEEEEST"
            indicator.startAnimating()
            
            rvc.controlDownloading()
        
        }else{
            print("Already downloading!!")
        }
    }
    var rvc: TabBarMainController!
    override func viewDidLoad() {
        super.viewDidLoad()
        rvc = self.tabBarController as? TabBarMainController //инициализация род. контролера
        print("Tournament table viewDidLoad()")
        if text.count == 0{
            indicator.startAnimating()
        }
        
        textView.text = text
        //print(tournamentTable.count)
        //fromMainConriler()

        // Do any additional setup after loading the view.
    }

     func recieveTabBarConroler(data: String){
        print("Данные пришли в TournamentTable \(data)")
        if textView == nil{
            self.text = data
        }else{
            indicator.stopAnimating()
            self.textView.text = data
            guard let tournamentTable = try? decoder.decode([TournamentTable].self, from: data.data(using: .utf8)!) else {
                print("TableConroler bad JSON decode")
                return
            }
            self.tournamentTable = tournamentTable
            //let table = try? decoder.decode([TournamentTable].self, from: arrayJSON[0].data(using: .utf8)!)
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
