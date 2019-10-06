//
//  CalendarController.swift
//  Exider.org
//
//  Created by Mark Glushko on 05/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class CalendarController: UIViewController {

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
    var calendar: [NextMatch]!
    let decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rvc = self.tabBarController as? TabBarMainController  //инициализация род. контролера
        print("CalendarConroler viewDidLoad()")
        indicator.startAnimating()
        // Do any additional setup after loading the view.
    }
    
    //Метод приема от главного контроера
    func recieveTabBarConroler(data: String){
        print("Данные пришли в Calendar \(data)")
        indicator.stopAnimating()
        if data == "ERROR"{
            textView.text = data
            present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
        }else{
           self.textView.text = data
            guard let calendar = try? decoder.decode([NextMatch].self, from: data.data(using: .utf8)!) else {
                print("CalendarConroler bad JSON decode")
                return
            }
            self.calendar = calendar
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
