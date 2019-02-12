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
            
            createMessageWithText(text: "Good Morning, My name is Steve Rogers.", friend: steve, minutesAgo: 2, context: context)
            createMessageWithText(text: "Thanos is coming,We need to be ready for this wars,Avengers Assemble !!!, Iron Man/Hulk/BlackWidow/This/Captain America/Hawkeyes", friend: steve, minutesAgo: 1, context: context)
            createMessageWithText(text: "Ms.Marvel is coming too.", friend: steve, minutesAgo: 0, context: context)
        
            let donald  = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Glover"
            donald.profileImageName = "glover"
            createMessageWithText(text: "Hi,Im Miles Morales's Uncle", friend: donald, minutesAgo: 0, context: context)
            
            
            let clint  = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            clint.name = "Clint Barton"
            clint.profileImageName = "barton"
            createMessageWithText(text: "Hi,Im Clint Barton", friend: clint, minutesAgo: 60 * 24, context: context)
            
            let natasha  = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            natasha.name = "Natasha Romanof"
            natasha.profileImageName = "romanof"
            createMessageWithText(text: "Hi,Im Natasha Romanof", friend: natasha, minutesAgo: 8 * 60 * 24, context: context)
            
            do{
                try context.save()
            }catch let error {
                print(error)
            }
        }
        loadData()
    }
    
    private func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext){
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo * 60)
    }
    
    func loadData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            if let friend = fetchFriends(){
                
                messages = [Message]()
                
                for friendx in friend {
                    print("\((friendx.name ?? ""))")
                    
                    let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
                    
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friendx.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let fetchMessages = try context.fetch(fetchRequest)
                        messages?.append(contentsOf: fetchMessages)
                    } catch {
                        print("Error fetching data \(error)")
                    }
                }
                
                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
                
            }
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            let Request = NSFetchRequest<Friend>(entityName: "Friend")
            
            do {
                return try ((context.fetch(Request) as? [Friend])!)
            } catch {
                print("Error fetching data \(error)")
            }
        }
        return nil
    }
}
