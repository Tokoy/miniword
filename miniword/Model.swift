//
//  Model.swift
//  words
//
//  Created by 章珂 on 2022/5/28.
//

import Foundation

struct EnglishModel: Codable,Hashable{
    var english:[Words]
}

struct Words:Codable,Hashable{
    var word : String
    var mean : String
}
