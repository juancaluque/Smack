//
//  SocketsService.swift
//  Smack
//
//  Created by Juan Luque on 1/14/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit
import SocketIO

class SocketsService: NSObject {

    static let instance = SocketsService()
    
    override init() {
        super.init()
    }
    
    //SOCKET CONNECTION
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    lazy var socket = manager.defaultSocket
    
    func establishConnection() {
        socket.connect()
        print("connected")
    }
   
    func closeConnection() {
        socket.disconnect()
        print("disconnected")
    }
    
    //CHANNEL FUNC
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelID)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    //MESSAGE FUNC
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    func getMessage(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String  else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                let newMessage = Message(message: msgBody, channelId: channelId, userName: userName, userId: id, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    func getTypingUser(_ completion: @escaping (_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completion(typingUsers)
        }
    }
    func stopTypingUser() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        socket.emit("stopType", UserDataService.instance.name, channelId)
    }
    func startTypingUser() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        socket.emit("startType", UserDataService.instance.name, channelId)
    }
}
