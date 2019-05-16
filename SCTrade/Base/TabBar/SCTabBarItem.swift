//
//  SCTabBarItem.swift
//  SCTrade
//
//  Created by Mark on 13/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import Foundation
import UIKit

struct SCTabBarItem {
    
    let name: String
    let selectedImage: UIImage?
    let unselectedImage: UIImage?
    
    var controller: UIViewController?
    var backgroundColor = SCColor.clear
    
    init(name: String,
         selectedImage: UIImage?,
         unselectedImage: UIImage?,
         controller: UIViewController?) {
        
        self.name = name
        self.selectedImage = selectedImage
        self.unselectedImage = unselectedImage
        self.controller = controller
    }
}
