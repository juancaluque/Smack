//
//  MessageService.swift
//  Smack
//
//  Created by Juan Luque on 1/13/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    // Variables
    var channels = [Channel]()
    var selectedChannel: Channel?
    var messages = [Message]()
    
    //Main Func
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }

                let json = try! JSON(data: data).array!
                for item in json{
                    let name = item["name"].stringValue
                    let channelDescription = item["description"].stringValue
                    let id = item["_id"].stringValue
                    let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                    self.channels.append(channel)
                }
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error)
//                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                
                guard let data = response.data else { return }
                if let json = try! JSON(data: data).array {
                    for item in json{
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStapm"].stringValue
                        
                        let message = Message(message: messageBody, channelId: channelId, userName: userName, userId: id, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    print(MessageService.instance.messages)
                    completion(true)
                }
            } else {
                debugPrint("HERE IS THE BUG\(response.result.error as Any)")
                completion(false)
            }
            
        }
    }
    
    //Other func
    func clearChannel() {
        channels.removeAll()
    }
    func clearMessages() {
        messages.removeAll()
    }
    
}

