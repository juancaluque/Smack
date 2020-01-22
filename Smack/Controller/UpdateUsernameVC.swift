//
//  UpdateUsernameVC.swift
//  Smack
//
//  Created by Juan Luque on 1/22/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class UpdateUsernameVC: UIViewController {

    // OUTLETS
    @IBOutlet weak var newUsernameText: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    // @IBACTIONS
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        if newUsernameText.text != "" {
            guard let newUsername = newUsernameText.text else { return }
            UserDataService.instance.updateName(name: newUsername)
            
            AuthService.instance.updateUsername(newUsername: newUsername) { (success) in
                if success {
                    print(UserDataService.instance.name)
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    // FUNC
    func setupView() {
        newUsernameText.attributedPlaceholder = NSAttributedString(string: "New username", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(recognizer:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    
    // OBJC FUNC
    @objc func closeTap(recognizer: UIGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
