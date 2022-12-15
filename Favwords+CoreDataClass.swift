//
//  Favwords+CoreDataClass.swift
//  miniword
//
//  Created by 章珂 on 2022/6/8.
//
//

import Foundation
import CoreData

@objc(Favwords)
public class Favwords: NSManagedObject {
    @NSManaged public var word: String?
    @NSManaged public var meanCn: String?
}
