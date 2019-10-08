//
//  NextMatch.swift
//  Exider.org
//
//  Created by Mark Glushko on 04/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation

class NextMatch: Decodable{
    var nameDivision: String?
    var idMatch: Int?
    var idDivision: Int?
    var idTour: Int?
    var teamHome: String?
    var teamVisit: String?
    var date: String?
    var nameStadium: String?
    var imageHome: String?
    var imageGuest: String?
}
