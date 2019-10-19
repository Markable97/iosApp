//
//  DownContentController.swift
//  Exider.org
//
//  Created by Mark Glushko on 19/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class DownContentController: UIViewController {

    var matchesVC: UIViewController!
    var statisticVC: UIViewController!
    var players: String!
    var results: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DownControler did load")
        configConroler()
        // Do any additional setup after loading the view.
    }
    
    func sendFromTeamVC(players: String, results: String){
        self.players = players
        self.results = results
        let sVC = self.statisticVC as! StatisticController
        sVC.sendFromDownVC(data: players)
        let mVC = self.matchesVC as! MatchesController
        mVC.sendFromDownVC(data: results)
    }
    
    func configConroler(){
        print("Подтяниваем контрлеры")
        //Первый контрлер при появлении
        let statisticVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "statisticVC") as! StatisticController
        self.statisticVC = statisticVC
        view.addSubview(statisticVC.view)
        addChild(statisticVC)
        //Второй контролер
        let matchesVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "matchesVC") as! MatchesController
        self.matchesVC = matchesVC
        view.insertSubview(matchesVC.view, at: 0)
        addChild(matchesVC)
    }

    func showOtherConroler(move: Bool){
        if move{
            //Показываем новый контролер
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.statisticVC.view.frame.origin.x = self.statisticVC.view.frame.width
            }) { (finished ) in
                
            }
        }else{
            //Убираем контрлер
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.statisticVC.view.frame.origin.x = 0
            }) { (finished ) in
                
            }
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
