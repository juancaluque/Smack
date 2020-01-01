//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Juan Luque on 1/1/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
