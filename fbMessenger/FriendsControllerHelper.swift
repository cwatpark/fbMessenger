//
//  FirendsControllerHelper.swift
//  fbMessenger
//
//  Created by Ice on 11/2/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import UIKit

class Friend: NSObject{
    var name: String?
    var profileImageName: String?
}

class Message: NSObject{
    var text:String?
    var date: NSDate?
    
    var friend: Friend?
}

extension FriendsController{
    func setupData(){
        
        let tony = Friend()
        tony.name = "Tony Stark"
        tony.profileImageName = "stark"
        
        let message = Message()
        message.friend = tony
        message.text = "Hello, My name is tony."
        message.date = NSDate()
        
        
        let steve = Friend()
        steve.name = "Steve Rogers"
        steve.profileImageName = "roger"
        
        let messageSteve = Message()
        messageSteve.friend = steve
        messageSteve.text = "Hello, My name is Steve Rogers."
        messageSteve.date = NSDate()
        
        messages = [message,messageSteve]
    }
}
