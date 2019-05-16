//
//  SCMarketsViewController.swift
//  SCTrade
//
//  Created by Mark on 13/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MBProgressHUD

class SCMarketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableview = UITableView()
    lazy var marketsInfoView = SCMarketsInfoView()
    
    let marketsInfoViewHeight: CGFloat = 59.0
    
    var currencyPair: [String] = []
    var currencyPairPrice: [SCCurrencyPairPrice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "SCMarketsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: SCMarketsTableViewCell.identifier)
        
        setupUI()
        showLoading()
        getCurrencyPair()
    }
    
    private func getCurrencyPair() {
        SCMarketsAPIManager
            .shared
            .getAllCurrencyPair {
                (error, currencyPair) in
                
                DispatchQueue.main.async {
                    [weak self] in
                    
                    guard let self = self else { return }
                    
                    self.currencyPair = currencyPair
                    self.getCurrencyPrice(currencyPair: currencyPair)
                }
            
        }
    }
    
    private func getCurrencyPrice(currencyPair: [String]) {
        SCMarketsAPIManager
            .shared
            .getCurrencyPrice(currencyPair: currencyPair) {
                (error, currencyPairPrice) in
                
                DispatchQueue.main.async {
                    [weak self] in
                    
                    guard let self = self else { return }
                    
                    self.currencyPairPrice = currencyPairPrice
                    
                    let balance = (currencyPairPrice.count*10000)
                    let equity = (currencyPairPrice.count*10000)
                    self.marketsInfoView.updateContent(equity: "\(equity)", balance: "\(balance)")
                    
                    self.tableview.reloadData()
                    
                    self.tableview.isHidden = false
                    self.marketsInfoView.isHidden = false
                    
                    self.hiddenLoading()
                }
        }
    }
    
    private func setupUI() {
        
        // view
        self.view.backgroundColor = SCColor.clear
        
        // navigation title
        self.title = "markets_title".localized
        self.navigationController?.navigationBar.barTintColor = SCColor.darkPurple
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SCColor.white]
        
        // markets info view
        marketsInfoView = UINib(nibName: "SCMarketsInfoView", bundle: nil).instantiate(withOwner: nil,
                                                                                       options: nil).first as! SCMarketsInfoView
        self.view.addSubview(marketsInfoView)
        marketsInfoView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(marketsInfoViewHeight)
        }
        marketsInfoView.backgroundColor = SCColor.clear
        marketsInfoView.isHidden = true
        
        // table view
        self.view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.snp.makeConstraints { (make) in
            
        let viewHeight = UIScreen.main.bounds.height - kStatusBarHeight - kNavigationBarheight - (marketsInfoViewHeight) - kTabBarHeight - 30  // 30 is padding
            make.height.equalTo(viewHeight)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableview.backgroundColor = SCColor.clear
        tableview.separatorStyle = .none
        tableview.isHidden = true
    }
    
    // MARK: loading
    func showLoading(isUserInteractionEnabled: Bool = false) {
        
        view.isUserInteractionEnabled = isUserInteractionEnabled
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.mode = MBProgressHUDMode.indeterminate
        loading.label.text = "loading".localized
    }
    
    func hiddenLoading() {
        view.isUserInteractionEnabled = true
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCMarketsTableViewCell.cellHeight
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyPairPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SCMarketsTableViewCell.identifier,
                                                    for: indexPath) as? SCMarketsTableViewCell {
            
            if currencyPairPrice.indices.contains(indexPath.row) {
                cell.updateContent(currencyPairPrice: currencyPairPrice[indexPath.row])
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}
