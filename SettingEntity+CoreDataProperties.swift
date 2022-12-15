//
//  SettingEntity+CoreDataProperties.swift
//  miniword
//
//  Created by 章珂 on 2022/6/8.
//
//

import Foundation
import CoreData


extension SettingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingEntity> {
        return NSFetchRequest<SettingEntity>(entityName: "SettingEntity")
    }

    @NSManaged public var changetime: Int32
    @NSManaged public var fontsize: Int32
    @NSManaged public var fontcolor: String?

}

extension SettingEntity : Identifiable {

}
