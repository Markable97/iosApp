//
//  RegisterViewController.swift
//  HelloWorld
//
//  Created by Mark Glushko on 28/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var teamTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var email: String = ""
    var password: String = ""

    //Нажатие на кнопку "Зарегистрироваться"
    @IBAction func onClickRegister(){
        print("clivk button register")
        /*guard let email = emailTF.text, let password = passwordTF.text, let team = teamTF.text, let name = nameTF.text else { return }*/
        let email = emailTF.text
        let password = passwordTF.text
        let team = teamTF.text
        let name = nameTF.text
        if email!.isEmpty || password!.isEmpty{
            print("password or email is emoty")
            present(AlertVisible.showAlert(message: "Необходимо ввести email и пароль"), animated: true, completion: nil)
        }else{
            //Вызов двух асинхронных потоков один для отображения анимации другой для выполнении отправки данных на сервер
            DispatchQueue.main.async {
                self.indicator.startAnimating()
                DispatchQueue.main.async {
                    self.sendData(name: name, team: team, email: email, password: password)
                }
            }
        }
    //Нажатие на кнопку "Уже есть аккаунт"
    }
    @IBAction func onClickAlreadyAkk(){
        print("click button already akk")
        performSegue(withIdentifier: "alreadyAkk", sender: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //убирание клавиатуры по нажатию на пустое место
    }
    
    func sendData(name: String?, team:String?, email: String?, password: String?){
        let userInfo = UserInfo(name: name!, team: team!, email: email!, password: password!)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let messageForServer = MessageJSON(messageLogic: "register", user_info: userInfo)
        let data = try? encoder.encode(messageForServer)
        print(String(data: data!, encoding: .utf8)!)
        /*if(Connect().connection(JSON: data!)){
            self.indicator.stopAnimating()
            print("register seccuss")
            self.email = email!
            self.password = password!
            performSegue(withIdentifier: "regUp", sender: nil)
        }else{
            self.indicator.stopAnimating()
            print("ERROR")
            present(AlertVisible.showAlert(message: "Ошибка сети"), animated: true, completion: nil)
        }*/
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
