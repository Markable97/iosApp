//
//  MessageJSON.swift
//  Exider.org
//
//  Created by Mark Glushko on 30/09/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation

struct MessageJSON: Codable {
    var messageLogic: String   
    var user_info: UserInfo
}
