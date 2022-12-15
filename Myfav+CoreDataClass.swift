//
//  Myfav+CoreDataClass.swift
//  miniword
//
//  Created by 章珂 on 2022/6/8.
//
//

import Foundation
import CoreData

@objc(Favwords)
public class Favwords: NSManagedObject {

        @NSManaged var word: String
        @NSManaged var meanCn: String
    
}

