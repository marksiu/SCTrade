//
//  SCMarketsTableViewCell.swift
//  SCTrade
//
//  Created by Mark on 13/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SCMarketsTableViewCell: UITableViewCell {
    
    static let identifier: String = "SCMarketsTableViewCell"
    static let cellHeight: CGFloat = 60.0
    
    @IBOutlet weak  var currencyPairLabel: UILabel!
    @IBOutlet weak  var sourceLabel: UILabel!
    @IBOutlet weak  var changeLabel: UILabel!
    @IBOutlet weak  var sellLabel: UILabel!
    @IBOutlet weak  var buyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func setupUI() {
        
        // cell
        selectionStyle = .none
        self.backgroundColor = SCColor.clear
        contentView.backgroundColor = SCColor.clear
        
        // currencyPairLabel
        currencyPairLabel.backgroundColor = SCColor.clear
        currencyPairLabel.textColor = SCColor.white
        currencyPairLabel.font = currencyPairLabel.font.withSize(16.0)
        currencyPairLabel.text = ""
        currencyPairLabel.textAlignment = .left
        
        // sourceLabel
        sourceLabel.backgroundColor = SCColor.clear
        sourceLabel.textColor = SCColor.middleBlue
        sourceLabel.font = sourceLabel.font.withSize(12.0)
        sourceLabel.text = ""
        sourceLabel.textAlignment = .left
        
        // changeLabel
        changeLabel.backgroundColor = SCColor.clear
        changeLabel.font = changeLabel.font.withSize(16.0)
        changeLabel.text = ""
        changeLabel.textAlignment = .left
        
        // sellLabel
        sellLabel.backgroundColor = SCColor.clear
        sellLabel.textColor = SCColor.white
        sellLabel.font = sellLabel.font.withSize(16.0)
        sellLabel.text = ""
        sellLabel.textAlignment = .left
        
        // buyLabel
        buyLabel.backgroundColor = SCColor.clear
        buyLabel.textColor = SCColor.white
        buyLabel.font = buyLabel.font.withSize(16.0)
        buyLabel.text = ""
        buyLabel.textAlignment = .left
        
        // indicatorImgView
//        indicatorImgView.backgroundColor = SCColor.clear

    }
    
    func updateContent(currencyPairPrice: SCCurrencyPairPrice) {
        // TODO: update color
        
        var currencyPairStr = currencyPairPrice.currencyPair
        if currencyPairPrice.currencyPair.count == 6 {
            currencyPairStr = currencyPairPrice.currencyPair.prefix(3) + "/" + currencyPairPrice.currencyPair.suffix(3)
        }
        currencyPairLabel.text = currencyPairStr
        
        
        sourceLabel.text = currencyPairStr + " : " + currencyPairPrice.source
        
        let sellPrice = Double(round(1000*currencyPairPrice.sellPrice)/1000)
        sellLabel.text = "\(sellPrice)"
        
        let buyPrice = Double(round(1000*currencyPairPrice.buyPrice)/1000)
        buyLabel.text = "\(buyPrice)"
    }
}
