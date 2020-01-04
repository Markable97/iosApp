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
    var name_league: String?
    var team_name: String?
    init(messageLogic: String, user_info: UserInfo){
        self.messageLogic = messageLogic
        self.user_info = user_info
    }
    init(messageLogic: String, id: Int){
        self.messageLogic = messageLogic
        self.id = id
    }
    init(messageLogic: String, name_league: String){
        self.messageLogic = messageLogic
        self.name_league = name_league
    }
    init(messageLogic: String, teamName: String){
        self.messageLogic = messageLogic
        self.team_name = teamName
    }
    var responseFromServer: String?
}
