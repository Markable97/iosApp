//
//  Connection.swift
//  Exider.org
//
//  Created by Mark Glushko on 29/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class Connection: NSObject {
    //1
       var inputStream: InputStream!
       var outputStream: OutputStream!
       
       //2
       var username = ""
       
       //3
       let maxReadLength = 4096
       
       func setupNetworkCommunication() {
         // 1
         var readStream: Unmanaged<CFReadStream>?
         var writeStream: Unmanaged<CFWriteStream>?

         // 2
         CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                            "192.168.0.106" as CFString,
                                            55555,
                                            &readStream,
                                            &writeStream)
         inputStream = readStream!.takeRetainedValue()
         outputStream = writeStream!.takeRetainedValue()
        inputStream.schedule(in: .current, forMode: .RunLoop.Mode.commonModes)
        outputStream.schedule(in: .current, forMode: .RunLoop.Mode.common)
         inputStream.open()
         outputStream.open()
       }
       
       func joinChat(username: String) {
         //1
         let data = "iam:\(username)".data(using: .ascii)!
         //2
         self.username = username
         
         //3
           print("for server \(data)\n\(data.count)")
         _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
       }
}
