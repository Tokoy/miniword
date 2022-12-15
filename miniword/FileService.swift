//
//  FileService.swift
//  words
//
//  Created by 章珂 on 2022/5/28.
//

import Foundation

class FileService {
    func fetchJsonFile() -> EnglishModel?{
        guard let url = Bundle.main.url(forResource: "success", withExtension: "json") else{
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            do {
                let fileData = try JSONDecoder().decode(EnglishModel.self, from: data)
                return fileData
            }
            catch{
                print(error.localizedDescription)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func fetchbookJsonFile() -> BookModel?{
        guard let url = Bundle.main.url(forResource: "bookList", withExtension: "json") else{
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            do {
                let fileData = try JSONDecoder().decode(BookModel.self, from: data)
                return fileData
            }
            catch{
                print(error.localizedDescription)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func fetchFavJsonFile() -> EnglishModel?{
        guard let url = Bundle.main.url(forResource: "english", withExtension: "json") else{
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            do {
                let fileData = try JSONDecoder().decode(EnglishModel.self, from: data)
                return fileData
            }
            catch{
                print(error.localizedDescription)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}
