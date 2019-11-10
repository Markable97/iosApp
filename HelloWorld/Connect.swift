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

    //let IP: String = "192.168.0.106"
    let IP: String = "213.248.20.145"
    let PORT: Int32 = 55555
    
    var client: TCPClient?
    
    func openConnect()->Bool{
        if client == nil{
            self.client = TCPClient(address: self.IP, port: self.PORT)
            switch client!.connect(timeout: 2){
                case .success:
                    print("connect with server********")
                    return true
                case .failure(let error):
                    print(error)
                    return false
            }
        }
        return false
    }
    
    func closeConnect(){
        if client != nil{
            client?.close()
        }
    }
    
   func connection(JSON:Data)->String{
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
                var data = [UInt8]()
                while true {
                    guard let response = client.read(1024*10, timeout: 2) else { break }
                    data += response
                }/*guard let data = client.read(1024*10, timeout: 10) else {
                    print("Error data read")
                    return "Error data read"
                }*/
                if data.count == 0{
                    print("Error data read")
                    return "Error data read"
                }else{
                    guard let response = String(bytes: data, encoding: .utf8) else {
                        return "Unknow error"
                    }
                      print(response)
                        let decoder = JSONDecoder()
                        let message = try? decoder.decode(MessageJSON.self, from: response.data(using: .utf8)!)
                        //client.close()
                        return message!.responseFromServer!
                    
                }
                
              case .failure(let error):
                print(error)
                return "Error send"
            }
          case .failure(let error):
            print(error)
            return "Error connect"
        }
    }
    
    func connectToServer(JSON:Data)->(Int,String){
        let byte = JSON
        switch client!.send(data: byte){
        case .success:
            print("message send")
            var data = [UInt8]()
            while true{
                guard let response = self.client!.read(1024*10, timeout: 2) else { break }
               data += response
            }
            if data.isEmpty{
                return(-1,"Error data read")
            }else{
                print("Count bytes from server 1 = \(data.count)")
                
                guard let response = String(bytes: data, encoding: .utf8) else {return (-1,"ERRO convert to String")}
                return (1,response)
            }
        case.failure(let error):
            print(error)
            return (-1,"Error send")
        }
    }
    
    func connectionToServer(JSON:Data, time: Int)->(Int,String){
        let byte = JSON
        let client = TCPClient(address: self.IP, port: self.PORT)
        switch client.connect(timeout: time ){
            case .success:
                print("connect with server********")
                switch client.send(data: byte) {
                    case .success:
                        print("message send")
                        var data_first = [UInt8]()
                        while true {
                            guard let response = client.read(1024*10, timeout: 2) else { break }
                            data_first += response
                        }
                        /*guard let data_first = client.read(4096, timeout: 10) else{
                            print("Error data read first")
                            return (-1,"Error data read")
                        }*/
                        if data_first.count == 0{
                            return(-1,"Error data read")
                        }else{
                            print("Count bytes from server 1 = \(data_first.count)")
                            
                            guard let response = String(bytes: data_first, encoding: .utf8) else {return (-1,"ERRO convert to String")}
                            //print("Data: \n \(response)")
                            client.close()
                            return (1,response)
                        }
                        
                    case .failure(let error):
                        print(error)
                        return (-1,"Error send")
                }
            case .failure(let error):
                print(error)
                return (-1,"Error connect")
        }
    }
    
}
