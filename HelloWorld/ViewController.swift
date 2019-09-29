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

   
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
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
        let login = loginTF.text
        let password = passwordTF.text
        if login!.isEmpty || password!.isEmpty {
            print("login or password is empty")
        }else{
            guard let login = login, let password = password else {return}
            print("Click button login = \(login) \n password = \(password)")
            if(connection(comand: "team")){
                print("seccuse")
                performSegue(withIdentifier: "mainView", sender: nil)
            }else{
                print("BAD :(")
            }
            
        }
    /*{"messageLogic":"login","id":1,"tour":1,"team_name":"Титан"},"user_info":{"name":"Dmitriy Lox","email":"markableglushko@yandex.com","team":"Mors","password":"DGlop791"},"settingForApp":0}*/
       
        
        
    }
    func connection(comand:String)->Bool{
        //let data = "iam:\(comand)".data(using: .ascii)!
        let forServer: String = "\"messageLogic\":\"\(comand)\",\"id\":1,\"tour\":1,\"team_name\":\"Титан\",\"user_info\":{\"name\":\"Dmitriy Lox\",\"email\":\"\(loginTF.text!)\",\"team\":\"Mors\",\"password\":\"DGlop791\"},\"settingForApp\":0}"
        print(forServer)
        let byte: Data? = "{\(forServer)".data(using: .utf8)!
        print(byte!.count)
        let client = TCPClient(address: "192.168.0.106", port: 55555)
        switch client.connect(timeout: 5) {
          case .success:
            print("connect with server********")
            switch client.send(data: byte! ) {
              case .success:
                print("message send")
                /*guard let data = client.read(1024*10) else { return false}

                if let response = String(bytes: data, encoding: .utf8) {
                  print(response)
                }*/
                client.close()
                return true
              case .failure(let error):
                print(error)
                return false
            }
          case .failure(let error):
            print(error)
            return false
        }
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
    
}

