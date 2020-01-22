//
//  ProfileVC.swift
//  Smack
//
//  Created by Juan Luque on 1/11/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(usernameDidChange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        let updateUsernameVC = UpdateUsernameVC()
        
        updateUsernameVC.modalPresentationStyle = .custom
        present(updateUsernameVC, animated: true, completion: nil)
    }

    func setupView() {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        let closetTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        bgView.addGestureRecognizer(closetTouch)
    }

    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    @objc func usernameDidChange() {
        setupView()
    }
}
