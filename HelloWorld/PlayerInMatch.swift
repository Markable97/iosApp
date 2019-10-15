//
//  PlayerInMatch.swift
//  Exider.org
//
//  Created by Mark Glushko on 15/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation
class PlayerInMatch: NSObject{
    var action: String!
    var name: String!
    var countAction: Int!
    
    init(action: String, name: String, countAction: Int){
        self.action = action
        self.name = name
        self.countAction = countAction
    }
}
