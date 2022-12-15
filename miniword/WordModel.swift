//
//  WordModel.swift
//  words
//
//  Created by 章珂 on 2022/6/5.
//

import Foundation

struct EnglishModel: Codable,Hashable {
    var english:[AllBookModel]
}

struct AllBookModel:Codable,Hashable {
    var AllWord:[Words]
    var bookCount: Int
    var bookId: Int
    var bookName: String
    var bookURL: String
    var category: String
}

struct Words:Codable,Hashable {
    var meanCn: String
    var word: String
    var wordId: Int
    var wordLevel: Int
}

