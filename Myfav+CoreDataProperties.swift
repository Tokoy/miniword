//
//  Myfav+CoreDataProperties.swift
//  miniword
//
//  Created by 章珂 on 2022/6/8.
//
//

import Foundation
import CoreData


extension Favwords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Myfav> {
        return NSFetchRequest<Myfav>(entityName: "Favwords")
    }

    @NSManaged public var word: String?
    @NSManaged public var meanCn: String?

}

extension Favwords : Identifiable {

}
