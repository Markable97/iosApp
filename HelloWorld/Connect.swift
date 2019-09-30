//
//  Connect.swift
//  Exider.org
//
//  Created by Mark Glushko on 30/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit
import SwiftSocket

class Connect: NSObject {

    let IP: String = "192.168.0.102"
    let PORT: Int32 = 55555
    
    
    
   func connection(JSON:Data)->Bool{
        //let data = "iam:\(comand)".data(using: .ascii)!
        /*let forServer: String = "\"messageLogic\":\"\(comand)\",\"id\":1,\"tour\":1,\"team_name\":\"Титан\",\"user_info\":{\"name\":\"Dmitriy Lox\",\"email\":\"\(loginTF.text!)\",\"team\":\"Mors\",\"password\":\"DGlop791\"},\"settingForApp\":0}"*/
        //print(forServer)
    //let byte: Data? = JSON.data(using: .utf8)!
        let byte = JSON
        print(byte.count)
        let client = TCPClient(address: self.IP, port: self.PORT)
        switch client.connect(timeout: 5) {
          case .success:
            print("connect with server********")
            switch client.send(data: byte) {
              //switch client.send(string: forServer ) {
                case .success:
                print("message send")
                guard let data = client.read(1024*10, timeout: 10) else {
                    print("Error data read")
                    return false
                }

                if let response = String(bytes: data, encoding: .utf8) {
                  print(response)
                }
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
    
}
