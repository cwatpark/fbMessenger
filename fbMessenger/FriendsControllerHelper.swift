//
//  FirendsControllerHelper.swift
//  fbMessenger
//
//  Created by Ice on 11/2/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController{
    
    func clearData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            let deleteFetchFriend = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            let deleteFetchMessage = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            let deleteFriendsRequest = NSBatchDeleteRequest(fetchRequest: deleteFetchFriend)
            let deleteMessagesRequest = NSBatchDeleteRequest(fetchRequest: deleteFetchMessage)
            do {
                try context.execute(deleteFriendsRequest)
                try context.execute(deleteMessagesRequest)
            } catch {
                print("Error clearing data \(error)")
            }
        }
    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let tony = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            
            //let tony = Friend()
            tony.name = "Tony Stark"
            tony.profileImageName = "stark"
            
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = tony
            message.text = "Hello, My name is tony."
            message.date = NSDate()
            
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Rogers"
            steve.profileImageName = "roger"
            
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Hello, My name is Steve Rogers."
            messageSteve.date = NSDate()
            
            do{
                try context.save()
            }catch let error{
                print(error)
            }
            
        }
       
        loadData()
        
    }
    
    func loadData(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
            
            do {
                messages = try context.fetch(fetchRequest)
            } catch {
                print("Error fetching data \(error)")
            }
            
        }
    }
}
