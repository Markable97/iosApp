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

    let IP: String = "192.168.0.106"
    let PORT: Int32 = 55555
    
    
    
   func connection(JSON:Data)->Bool{
        //let data = "iam:\(comand)".data(using: .ascii)!
        /*let forServer: String = "\"messageLogic\":\"\(comand)\",\"id\":1,\"tour\":1,\"team_name\":\"Титан\",\"user_info\":{\"name\":\"Dmitriy Lox\",\"email\":\"\(loginTF.text!)\",\"team\":\"Mors\",\"password\":\"DGlop791\"},\"settingForApp\":0}"*/
        //print(forServer)
    //let byte: Data? = JSON.data(using: .utf8)!
        let byte = JSON
        print(byte.count)
        let client = TCPClient(address: self.IP, port: self.PORT)
        switch client.connect(timeout: 2) {
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
    func connectionDivision(JSON:Data)->Bool{
        let byte = JSON
        let client = TCPClient(address: self.IP, port: self.PORT)
        switch client.connect(timeout: 5){
            case .success:
                print("connect with server********")
                switch client.send(data: byte) {
                    case .success:
                        print("message send")
                        let data_first = client.read(1024*50, timeout: 2)
                        if data_first == nil{
                            print("Error data read first")
                        }else {
                            print("Count bytes from server 1 = \(data_first!.count)")
                        }
                        
                        let data_second = client.read(1024*59, timeout: 2)
                        if data_second == nil {
                            print("Error data read first")
                        }else {
                            print("Count bytes from server 2= \(data_second!.count)")
                        }
                       
                        let data_third = client.read(1024*59, timeout: 2)
                        if data_third == nil{
                           print("Data third = nill")
                        }else{
                           print("Data from server 3 \(data_third!.count)")
                        }
                        

                        let response = String(bytes: data_first!, encoding: .windowsCP1251)
                        print("Data TOURNAMENT: \n \(response!)")
                        
                        let decoder = JSONDecoder()
                        let table = try? decoder.decode([TournamentTable].self, from: response!.data(using: .utf8)!)
                        print("table = \(table!.count)")
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
