//
//  AlertVisible.swift
//  Exider.org
//
//  Created by Mark Glushko on 01/10/2019.
//  Copyright © 2019 Mark Glushko. All rights reserved.
//

import UIKit

class AlertVisible: NSObject {

    static func showAlert(message: String) -> UIAlertController{
        let allert = UIAlertController(title: "Предупреждение", message: message, preferredStyle: .alert)
        let allertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        allert.addAction(allertAction)
        return allert
    }
    
}
