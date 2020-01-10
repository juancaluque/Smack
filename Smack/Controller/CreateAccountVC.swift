//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Juan Luque on 1/1/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController, AvatarTransfer {

    //Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bell = ""
    var bgColor: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

//    override func viewDidAppear(_ animated: Bool) {
//        if UserDataService.instance.avatarName != "" {
//            userImage.image = UIImage(named: UserDataService.instance.avatarName)
//            avatarName = UserDataService.instance.avatarName
//        }
//    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = emailTxt.text , emailTxt.text != " " else { return }
        guard let pass = passTxt.text , passTxt.text != " " else { return }
        guard let name = userNameTxt.text , userNameTxt.text != " " else { return }
        
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            self.spinner.isHidden = false
                            self.spinner.stopAnimating()
                            print(UserDataService.instance.name, UserDataService.instance.avatarName)
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_AVATAR_PICKER {
            guard let avatarPicker = segue.destination as? AvatarPickerVC else { return }
            avatarPicker.delegate = self
        }
    }
    
    func updateAvatarName(avatarName: String) {
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            self.avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil{
                userImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        self.bell = "on"
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2) {
            self.userImage.backgroundColor = self.bgColor
        }
    }
    
    func setupView() {
        spinner.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
