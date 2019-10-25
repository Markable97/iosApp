//
//  PrevMatch.swift
//  Exider.org
//
//  Created by Mark Glushko on 04/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation
class PrevMatch: Decodable{
    var id_match: Int?
    var nameDivision: String?
    var idTour: Int?
    var teamHome: String?
    var goalHome: Int?
    var goalVisit: Int?
    var teamVisit: String?
    var imageHome: String?
    var imageGuest: String?
    var played: Int?
}
