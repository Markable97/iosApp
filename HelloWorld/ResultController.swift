//
//  ResultController.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class ResultController: UIViewController{

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var results: [PrevMatch]!
    let decoder = JSONDecoder()
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ResultConroler: viewDidLoad")
        if text.count == 0{
            indicator.startAnimating()
        }
        
        textView.text = text
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
        print("Данные пришли в Result \(data)")
        if textView == nil{
            self.text = data
        }else{
            indicator.stopAnimating()
            self.textView.text = data
            guard let results = try? decoder.decode([PrevMatch].self, from: data.data(using: .utf8)!) else {
                print("ResultConroler bad JSON decoder")
                return
            }
            self.results = results
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
