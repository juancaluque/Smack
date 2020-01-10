//
//  CircleImage.swift
//  Smack
//
//  Created by Juan Luque on 1/10/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}
