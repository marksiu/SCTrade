//
//  SCTabBarItemView.swift
//  SCTrade
//
//  Created by Mark on 13/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import UIKit
import SnapKit

class SCTabBarItemView: UIView {
    
    weak var imageView: UIImageView!
    weak var label: UILabel!
    
    var selectedImage: UIImage?
    var unselectedImage: UIImage?
    
    var selectedTextColor = SCColor.lightWhite
    var unselectedTextColor = SCColor.middleBlue
    
    var selected = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    private func setupUI() {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(10.0)
            make.width.equalTo(22.0)
            make.height.equalTo(22.0)
        }
        self.imageView = imageView
        self.imageView.backgroundColor = SCColor.clear
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(2.0)
            make.height.equalTo(14.0)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        label.font = label.font.withSize(12)
        self.label = label
    }
    
    func updateUI() {
        self.label.textColor = self.selected ? self.selectedTextColor : self.unselectedTextColor
    }
}
