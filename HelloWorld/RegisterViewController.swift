//
//  RegisterViewController.swift
//  HelloWorld
//
//  Created by Mark Glushko on 28/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var email: String = ""
    var password: String = ""

    //Нажатие на кнопку "Зарегистрироваться"
    @IBAction func onClickRegister(){
        print("clivk button register")
        guard let email = emailTF.text, let password = passwordTF.text else { return }
        if email.isEmpty || password.isEmpty{
            print("password or email is emoty")
        }else{
            self.email = email
            self.password = password
            performSegue(withIdentifier: "regUp", sender: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
