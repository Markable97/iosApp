//
//  MessageJSON.swift
//  Exider.org
//
//  Created by Mark Glushko on 30/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation

class MessageJSON: Codable {
    var messageLogic: String?
    var id: Int?
    var user_info: UserInfo?
    init(messageLogic: String, user_info: UserInfo){
        self.messageLogic = messageLogic
        self.user_info = user_info
    }
    init(messageLogic: String, id: Int){
        self.messageLogic = messageLogic
        self.id = id
    }
    var responseFromServer: String?
}
