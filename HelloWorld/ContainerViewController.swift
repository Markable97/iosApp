//
//  ContainerViewController.swift
//  Exider.org
//
//  Created by Mark Glushko on 10/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit


class ContainerViewController: UIViewController, MenuDelegate, MenuItem {


    var tabBarControler: UITabBarController!
    var menuConroler: UIViewController!
    var menuControlerClass: MenuController!
    var isMove = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configTabBarConroler()
    }
    

    func configTabBarConroler(){
        let tabBarControler = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "mainTabBar") as! TabBarMainController
        tabBarControler.delegateMenu = self
        self.tabBarControler = tabBarControler
        view.addSubview(tabBarControler.view)
        addChild(tabBarControler)
    }
    func conficMenuControler(divisionsJSON: String){
        if menuConroler == nil{
            let menuControler = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "test_id") as! MenuController
            menuControler.delegateItem = self
            self.menuControlerClass = menuControler
            self.menuConroler = menuControler
            view.insertSubview(self.menuConroler.view, at: 0)
            addChild(menuConroler)
            print("add MENU")
            menuControler.refresh(data: divisionsJSON)
        }
    }
    
    func showMenu(move: Bool){
        if move{
            //показывает меню
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.tabBarControler.view.frame.origin.x = self.tabBarControler.view.frame.width - 100
            }) { (finished ) in
                
            }
        }else{
            //убирает меню
            let controler = self.tabBarControler as! TabBarMainController
            controler.close()
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.tabBarControler.view.frame.origin.x = 0
            }) { (finished ) in
                
            }
            
        }
    }
    
    func toggleMenu(divisionsJSON: String, downloadMenu: Bool) {
        if downloadMenu {
            conficMenuControler(divisionsJSON: divisionsJSON)
            isMove = !isMove
            showMenu(move: isMove)
        }else{
            
        }
    }
    func onClickItem(idDivsion: Int, nameDivision: String) {
        print("click item \(idDivsion)")
        isMove = !isMove
        showMenu(move: isMove)
        let controler = self.tabBarControler as! TabBarMainController
        controler.idDivision = idDivsion
        controler.startAllIndicator(titleName: nameDivision)
        let query = DispatchQueue.global(qos: .utility)
        query.async {
            controler.sendData(logic: "division")
        }
    }
    func onSwipCloseMenu() {
        isMove = !isMove
        showMenu(move: isMove)
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
