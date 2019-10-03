//
//  UserInfo.swift
//  Exider.org
//
//  Created by Mark Glushko on 30/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation

class UserInfo: Codable{
    var name: String
    var email: String
    var team: String
    var password: String
    
    init(){
        self.name = ""
        self.team = ""
        self.email = ""
        self.password = ""
    }
    
    init(email: String, password: String){
        self.name = ""
        self.email = email
        self.team = ""
        self.password = password
    }
    init(name: String, team: String, email: String, password: String){
        self.name = name
        self.team = team
        self.email = email
        self.password = password
    }
    
}
