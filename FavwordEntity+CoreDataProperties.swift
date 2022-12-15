//
//  FavwordEntity+CoreDataProperties.swift
//  miniword
//
//  Created by 章珂 on 2022/6/8.
//
//

import Foundation
import CoreData


extension FavwordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavwordEntity> {
        return NSFetchRequest<FavwordEntity>(entityName: "FavwordEntity")
    }

    @NSManaged public var word: String?
    @NSManaged public var meanCn: String?

}

extension FavwordEntity : Identifiable {

}
