//
//  PlayerInStatistic.swift
//  Exider.org
//
//  Created by Mark Glushko on 21.10.2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import Foundation
class PlayerInStatistic{
    var typeCell:String?
    var player: Player?
    var amplua: String?
    init(typeCell: String, player: Player){
        self.typeCell = typeCell
        self.player = player
    }
    init(typeCell: String, amplua: String) {
        self.typeCell = typeCell
        self.amplua = amplua
    }
    init(typeCell: String){
        self.typeCell = typeCell
    }
}
