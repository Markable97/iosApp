//
//  MainSetting+CoreDataProperties.swift
//  
//
//  Created by Mark Glushko on 22.10.2019.
//
//

import Foundation
import CoreData


extension MainSetting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainSetting> {
        return NSFetchRequest<MainSetting>(entityName: "MainSetting")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?

}
