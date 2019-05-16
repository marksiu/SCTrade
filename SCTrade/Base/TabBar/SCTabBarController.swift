//
//  SCTabBarController.swift
//  SCTrade
//
//  Created by Mark on 13/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

private let kDefaultTabBarItemType: SCTabBarItemType = .markets

enum SCTabBarItemType: Int {
    case markets = 0
    case portfolio
    case chats
    case profile
}

class SCTabBarController: UIViewController {

    var contentView: UIView!
    var tabBarView: UIView!
    
    var currentVC: UIViewController?
    
    var tabBarItemArr = [SCTabBarItem]()
    var selectedTabBarItemType: SCTabBarItemType = kDefaultTabBarItemType
    var tabBarItemViewArr = [SCTabBarItemView]()
    
    var isFirstViewDidLayoutSubviews: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTabBarItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            setupTabBarView()
    }
    
    override func viewWillAppear(_ animation: Bool) {
        super.viewWillAppear(animation)
    }
    
    private func setupUI() {
        
        tabBarView = UIView()
        self.view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(kTabBarHeight)
        }
        tabBarView.backgroundColor = SCColor.superDark
        
        contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(tabBarView.snp.top)
        }
        contentView.backgroundColor = SCColor.deepDark
    }
    
    private func setupTabBarItem() {
        let marketsVC = SCMarketsViewController(nibName:"SCMarketsViewController", bundle: nil)
        let marketsNVC = UINavigationController(rootViewController: marketsVC)
        
        let tempVC = UIViewController()
        tempVC.view.backgroundColor = SCColor.clear
        
        let marketsTabBarItem = SCTabBarItem(name: "tab_markets".localized,
                                             selectedImage: "".image,
                                             unselectedImage: "".image,
                                             controller: marketsNVC)
        
        let portfolioTabBarItem = SCTabBarItem(name: "tab_portfolio".localized,
                                               selectedImage: "".image,
                                               unselectedImage: "".image,
                                               controller: nil)
        
        let chatsTabBarItem = SCTabBarItem(name: "tab_chats".localized,
                                           selectedImage: "".image,
                                           unselectedImage: "".image,
                                           controller: nil)
        
        let profileTabBarItem = SCTabBarItem(name: "tab_profile".localized,
                                             selectedImage: "".image,
                                             unselectedImage: "".image,
                                             controller: nil)
        
        self.tabBarItemArr = [marketsTabBarItem,
                              portfolioTabBarItem,
                              chatsTabBarItem,
                              profileTabBarItem]
        
        self.transitToController(atIndex: self.selectedTabBarItemType.rawValue)
    }
    
    func setupTabBarView() {
        
        guard self.isViewLoaded else { return }
        
        for view in self.tabBarItemViewArr {
            view.removeFromSuperview()
        }
        self.tabBarItemViewArr = []
        
        var tabBarItemViewArr = [SCTabBarItemView]()
        
        for (index, item) in self.tabBarItemArr.enumerated() {
            
            let itemView = SCTabBarItemView()
            itemView.tag = index
            itemView.label.text = item.name
            itemView.selectedImage = item.selectedImage
            itemView.unselectedImage = item.unselectedImage
            if self.selectedTabBarItemType.rawValue == index {
                itemView.selected = true
            }
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.tabBarItemDidPress)))
            
            itemView.updateUI()
            
            self.tabBarView.addSubview(itemView)
            // update item layout in here
            itemView.snp.makeConstraints { (make) in
                
                make.centerY.equalToSuperview()
                make.height.equalTo(kTabBarHeight)
                let width: CGFloat = UIScreen.main.bounds.width/CGFloat(self.tabBarItemArr.count)
                make.width.equalTo(width)
                let leftPadding = width*CGFloat(index)
                make.left.equalTo(leftPadding)
            }
            
            tabBarItemViewArr.append(itemView)
        }
        self.tabBarItemViewArr = tabBarItemViewArr
    }
    
    func updateTabBarView() {
        
        for itemView in tabBarItemViewArr {
            itemView.selected = false
        }
        self.tabBarItemViewArr[self.selectedTabBarItemType.rawValue].selected = true
        
        for itemView in tabBarItemViewArr {
            itemView.updateUI()
        }
    }
    
    func transitToController(atIndex index: Int) {
        
        guard index < self.tabBarItemArr.count else { return }
        
        if let previousVC = self.currentVC {
            
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            self.currentVC = nil
        }
        
        let item = self.tabBarItemArr[index]
        guard let controller = item.controller else { return }
        let view = controller.view!
        
        self.addChild(controller)
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        controller.didMove(toParent: self)
        self.currentVC = controller
    }
    
    @objc func tabBarItemDidPress(sender: UIGestureRecognizer) {
        
        guard let index = sender.view?.tag else { return }
        guard let selectedItemType = SCTabBarItemType(rawValue: index) else { return }
        
        self.selectedTabBarItemType = selectedItemType
        self.updateTabBarView()
        self.transitToController(atIndex: selectedItemType.rawValue)
    }
}
