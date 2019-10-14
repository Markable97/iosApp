//
//  Player.swift
//  Exider.org
//
//  Created by Mark Glushko on 13/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation
class Player: Decodable{
    var idPlayer: Int!
    var playerTeam: String!
    var playerName: String!
    var birhtday: String!
    var amplua: String!
    var number: Int!
    var games: Int!
    var goal: Int!
    var penalty: Int!
    var assist: Int!
    var yellowCard: Int!
    var redCard: Int!
    var penalty_out: Int!
    var own_goal: Int!
}
