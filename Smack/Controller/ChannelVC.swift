//
//  ChannelVC.swift
//  Smack
//
//  Created by Juan Luque on 12/30/19.
//  Copyright © 2019 Juan Luque. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //Outlet
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }

    @IBAction func logInBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            logInBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            logInBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
    

    

}
