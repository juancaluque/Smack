//
//  TestAuthService.swift
//  Smack
//
//  Created by Juan Luque on 1/6/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

//CONSTANTS

typealias TestCompletionHandler = (_ Success: Bool) -> ()

//User Defaults
let TEST_LOGGED_IN_KEY = "loggedIn"
let TEST_USER_EMAIL = "userEmail"
let TEST_TOKEN_KEY = "token"

//Header
let TEST_HEADER = [
    "Content-type": "application/json; charset=utf-8"
]

//URLS
let TEST_BASE_URL = "https://damp-forest-50249.herokuapp.com/v1/"
let TEST_URL_REGISTER = "\(BASE_URL)account/register"
let TEST_URL_LOGIN = "\(BASE_URL)account/login"







//AUTHSERVICE

class TestAuthService {
    static let instance = TestAuthService()
    
    var defaults = UserDefaults.standard
    
    var testIsLoggedIn: Bool{
        get{
            return defaults.bool(forKey: TEST_LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: TEST_LOGGED_IN_KEY)
        }
    }
    var testUserEmail: String{
        get{
            return defaults.value(forKey: TEST_USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: TEST_USER_EMAIL)
        }
    }
    var testAuthToken: String {
        get{
            return defaults.value(forKey: TEST_TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TEST_TOKEN_KEY)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping TestCompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "pasword": password
        ]
        
        Alamofire.request(TEST_URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: TEST_HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping TestCompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(TEST_URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: TEST_HEADER).responseJSON { (response) in
            if response.result.error == nil{
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if  let email = json["user"] as? String{
//                        self.testUserEmail = email
//                    }
//                    if let token = json["token"] as? String{
//                        self.testAuthToken = token
//                    }
//                }
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                self.testUserEmail = json["user"].stringValue
                self.testAuthToken = json["token"].stringValue
                
                self.testIsLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
            
        
        
        
    }
}
    
