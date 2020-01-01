//
//  LogInVC.swift
//  Smack
//
//  Created by Juan Luque on 12/31/19.
//  Copyright © 2019 Juan Luque. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    

}
