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
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
    }
    
    @IBAction func logInBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    

    

}
