//
//  CoreDataManager.swift
//  NotesCoreData
//
//  Created by Admin on 21.06.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name:"DataCore")
        persistentContainer.loadPersistentStores{ (description, error) in
            if let error = error {
                fatalError("Core Data error \(error.localizedDescription)")
            }
            
        }
    }
    
    func getAllDate() -> [EntityData] {
        let fetchRequest : NSFetchRequest<EntityData> = EntityData.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch{
            return []
        }
    }
    
    
    func saveData(tittle: String, data: String){
        
        let entityData = EntityData(context: persistentContainer.viewContext)
     
        entityData.tittle = tittle
        entityData.data = data
        
        do {
            try persistentContainer.viewContext.save()
        } catch{
            print("error save \(error)")
        }
        
    }
    
    func deleteData(data: EntityData) {
            
            persistentContainer.viewContext.delete(data)
            
            do {
                try persistentContainer.viewContext.save()
            } catch {
                persistentContainer.viewContext.rollback()
                print("Failed to save context \(error)")
            }
            
        }
    
    func updateData() {
           
           do {
               try persistentContainer.viewContext.save()
           } catch {
               persistentContainer.viewContext.rollback()
           }
           
       }
    
}
