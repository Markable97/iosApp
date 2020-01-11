//
//  ContainerTabBarMainController.swift
//  Exider.org
//
//  Created by Mark Glushko on 11.01.2020.
//  Copyright © 2020 Mark Glushko. All rights reserved.
//

import UIKit
import GoogleMobileAds
protocol CheatDelegate{
    func useCheating()
}
class ContainerTabBarMainController: UIViewController {

    var childConroller: TabBarMainController?
    var mainCheat: ContainerViewController?
    @IBOutlet weak var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start ContainerViewConroller")
        // Do any additional setup after loading the view.
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedTabBar"{
            let tabBarChild = segue.destination as! TabBarMainController
            tabBarChild.delegateMenu =  mainCheat.self //сюда передам из главного окна self
            self.childConroller = tabBarChild
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
