//
//  TournamentTable.swift
//  Exider.org
//
//  Created by Mark Glushko on 03/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class TournamentTable: NSObject, Codable  {
    var divisionName: String?
    var teamName: String?
    var games: Int?
    var points: Int?
    var wins: Int?
    var draws: Int?
    var losses: Int?
    var goalScored: Int?
    var goalConceded: Int?
    var sc_con: Int?
}
