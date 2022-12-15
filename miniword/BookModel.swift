//
//  Model.swift
//  words
//
//  Created by 章珂 on 2022/5/28.
//

import Foundation

struct BookModel: Codable,Hashable{
    var books:[Books]
}

struct Books:Codable,Hashable{
    var bookId : Int
    var bookCount : String
    var bookName : String
}
