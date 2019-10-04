//
//  ViewController.swift
//  HelloWorld
//
//  Created by Mark Glushko on 27/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit
import SwiftSocket

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
    }
   
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction  func returnOnViewConroler(seque: UIStoryboardSegue){
        if seque.identifier == "alreadyAkk"{
            print("usual return")
        }else{
            guard let svc = seque.source as? RegisterViewController else { return }
            print("data from registerControler: \n email - \(svc.email) \n password - \(svc.password)")
            loginTF.text = svc.email
            passwordTF.text = svc.password
        }
    }
    
    //Вход
    @IBAction func onClickRegIn(_ sender: UIButton) {
        //indicator.isHidden = false//indicator.startAnimating()
        let login = loginTF.text
        let password = passwordTF.text
        if login!.isEmpty || password!.isEmpty {
            print("login or password is empty")
            //present(AlertVisible.showAlert(message: "Необходимо ввести email и пароль"), animated: true, completion: nil)
             performSegue(withIdentifier: "mainView", sender: nil)
            //self.indicator.stopAnimating()
        }else{
            //Вызов двух асинхронных потоков один для отображения анимации другой для выполнении отправки данных на сервер
            DispatchQueue.main.async {
                self.indicator.startAnimating()
                DispatchQueue.main.async {
                    self.sendData(login: login, password: password)
                }
            }
            
        }
    /*{"messageLogic":"login","id":1,"tour":1,"team_name":"Титан"},"user_info":{"name":"Dmitriy Lox","email":"markableglushko@yandex.com","team":"Mors","password":"DGlop791"},"settingForApp":0}*/
       
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mainView"{
            guard let dvc = segue.destination as? MainViewController else {
                return
            }
            dvc.login = loginTF.text
        }/*else{
            guard segue.destination as? RegisterViewController else {
                return
            }
        }*/
        
    }
    //Регистрация
    @IBAction func onClickRegUp(_ sender: UIButton){
        print("Click button register")
        performSegue(withIdentifier: "registerView", sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //убирание клавиатуры по нажатию на пустое место
    }
    
    //Отправка данные на сервер
    func sendData(login: String?, password: String?){
        print("Click button login = \(login!) \n password = \(password!)")
        let userInfo = UserInfo(email: login!, password: password!)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: "login", user_info: userInfo)
        let data = try? encoder.encode(messageForServer)
        print(String(data: data!, encoding: .utf8)!)
        
        //UIApplication.shared.beginIgnoringInteractionEvents()
        switch Connect().connection(JSON: data!) {
        case "Password successfull":
            indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            print("password seccuss")
            performSegue(withIdentifier: "mainView", sender: nil)
        case "The password does not match":
            indicator.stopAnimating()
            print("bad password or login")
            present(AlertVisible.showAlert(message: "Не правильный логин или пароль :("), animated: true, completion: nil)
        default:
            indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            print("ERROR")
            present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
        }
        /*if(Connect().connection(JSON: data!)){
            indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            print("password seccuss")
            performSegue(withIdentifier: "mainView", sender: nil)
        }else{
            indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            print("ERROR")
            present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
        }*/
    }
    
}

