//
//  CMDataBaseManager.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 25/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit
import CoreData

class CMDataBaseManager: NSObject {
    
    static let sharedManager = CMDataBaseManager()
    //var persistentContainer:NSPersistentContainer
    var cdObjectContext:NSManagedObjectContext?
    var cdObjectModel:NSManagedObjectModel?
    var cdPersistantStoreCoordinator:NSPersistentStoreCoordinator?
    
    override init() {
        
        super.init()
        
        self.setManagedObjectModel()
        self.setPersisStoreCoordinator()
        self.setManagedObjectContext()
        
        /*
        self.persistentContainer = {
            
            let container = NSPersistentContainer(name: "GameBoard")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()*/
    }
    
    func setManagedObjectContext() -> Void {
        
        let managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = self.cdPersistantStoreCoordinator
        self.cdObjectContext = managedObjectContext
        
    }
    
    func setManagedObjectModel() -> Void {
        
        if self.cdObjectModel != nil{
            
            return
        }
        
        let modelURL = Bundle.main.url(forResource: "GameBoard", withExtension: "momd")
        self.cdObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        
    }
    
    func setPersisStoreCoordinator() -> Void {
        
        if self.cdPersistantStoreCoordinator != nil{
            
            return
        }
        
        let storeURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent("GameBoard.sqlite")
        
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.cdObjectModel!)
        
        do {
            _ = try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            
            self.cdPersistantStoreCoordinator = storeCoordinator
            
        } catch {
            let nserror = error as NSError
            print("Error: ",nserror)
            //fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        
        
    }
    
    func saveContext () {
        
        if self.cdObjectContext != nil{
            
            if (self.cdObjectContext?.hasChanges)!{
                
                do {
                    
                    try self.cdObjectContext?.save()
                    
                } catch _ as NSError {
                    
                    
                }
            }
        }
        
       /* let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }*/
    }
    
    func savePlayerInformation(name data:String, score:Int) -> Void {
        
        let objPlayer = NSEntityDescription.entity(forEntityName: "Player", in: self.cdObjectContext!)
        let player = NSManagedObject(entity: objPlayer!, insertInto: self.cdObjectContext!)
        player.setValue(data, forKey: "playerName")
        player.setValue(score, forKey: "points")
        
        self.saveContext()
        
    }
    
    func getPlayerList() -> Array<Player>? {
        
        let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        fetchResult.sortDescriptors = [NSSortDescriptor(key: "points", ascending: false)]
        
        do {
            let arrPlayer = try self.cdObjectContext!.fetch(fetchResult) as? Array<Player>
            
            return arrPlayer
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print("fetchResult: ",fetchResult);
        
        return nil
        
        
    }
    
    func updatePlayerRank() -> Void {
        
        if let arr = self.getPlayerList(){
    
            var previousPlayerPoints:Int16 = arr[0].points
            var playerRank:Int16 = 1
            for obj in arr{
                
                if obj.points == previousPlayerPoints {
                    
                    obj.rank = playerRank
                    
                }else if obj.points < previousPlayerPoints{
                    
                    playerRank = playerRank + 1
                    
                    obj.rank = playerRank
                }
                
                previousPlayerPoints = obj.points
            }
            
            self.saveContext()
            
        }
        
    }

}

// MARK: - Core Data stack



// MARK: - Core Data Saving support


