//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Juan Luque on 1/1/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTxt.text , emailTxt.text != " " else { return }
        guard let pass = passTxt.text , passTxt.text != " " else { return }
        guard let name = userNameTxt.text , userNameTxt.text != " " else { return }
        
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                            print(UserDataService.instance.name, UserDataService.instance.avatarName)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
        
    }
    
    
   
    
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
