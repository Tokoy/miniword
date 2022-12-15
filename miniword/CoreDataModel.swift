//
//  CoreDataModel.swift
//  miniword
//
//  Created by 章珂 on 2022/6/9.
//

import Foundation
import CoreData


final class CoreDataModel: ObservableObject {
    @Published var favwords: [FavwordEntity] = []
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name: "miniword")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        queryFav()
    }
    
    func savedata(){
        do {
            try container.viewContext.save()
            queryFav()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    func addFav(word:String,mean:String){
        let newfavword = FavwordEntity(context:container.viewContext)
        newfavword.word = word
        newfavword.meanCn = mean
        savedata()
    }
    
    
    func deleteFav(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let favword = favwords[index]
        container.viewContext.delete(favword)
        savedata()
    }
    
    
    func queryFav(){
        let query = NSFetchRequest<FavwordEntity>(entityName: "FavwordEntity")
        
        do {
            favwords = try container.viewContext.fetch(query)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func searchFav(word:String){
        savedata()
    }
}
