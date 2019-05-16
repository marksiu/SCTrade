//
//  SCMarketsInfoView.swift
//  SCTrade
//
//  Created by Mark on 13/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import UIKit
import SnapKit

class SCMarketsInfoView: UIView {
    
    // TODO: add image
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var equiryTitleLabel: UILabel!
    @IBOutlet var equiryContentLabel: UILabel!
    
    @IBOutlet var balanceTitleLabel: UILabel!
    @IBOutlet var balanceContentLabel: UILabel!
    
    @IBOutlet var marginTitleLabel: UILabel!
    @IBOutlet var marginContentLabel: UILabel!
    
    @IBOutlet var usedTitleLabel: UILabel!
    @IBOutlet var usedContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        backgroundColor = SCColor.clear
        
        backgroundView.backgroundColor = SCColor.slowBlue
        backgroundView.layer.cornerRadius = 10
        
        equiryTitleLabel.backgroundColor = SCColor.clear
        equiryTitleLabel.textColor = SCColor.middleBlue
        equiryTitleLabel.text = "markets_equity".localized
        equiryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        equiryTitleLabel.font = equiryTitleLabel.font.withSize(12)
        
        equiryContentLabel.backgroundColor = SCColor.clear
        equiryContentLabel.textColor = SCColor.white
        equiryContentLabel.text = ""
        equiryContentLabel.translatesAutoresizingMaskIntoConstraints = false
        equiryContentLabel.font = equiryContentLabel.font.withSize(12)
        
        balanceTitleLabel.backgroundColor = SCColor.clear
        balanceTitleLabel.textColor = SCColor.middleBlue
        balanceTitleLabel.text = "markets_balance".localized
        balanceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceTitleLabel.font = balanceTitleLabel.font.withSize(12)
        
        balanceContentLabel.backgroundColor = SCColor.clear
        balanceContentLabel.textColor = SCColor.white
        balanceContentLabel.text = ""
        balanceContentLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceContentLabel.font = balanceContentLabel.font.withSize(12)
        
        marginTitleLabel.backgroundColor = SCColor.clear
        marginTitleLabel.textColor = SCColor.middleBlue
        marginTitleLabel.text = "markets_margin".localized
        marginTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        marginTitleLabel.font = marginTitleLabel.font.withSize(12)
        
        marginContentLabel.backgroundColor = SCColor.clear
        marginContentLabel.textColor = SCColor.white
        marginContentLabel.text = "$9,971.92"  // hardcoded
        marginContentLabel.translatesAutoresizingMaskIntoConstraints = false
        marginContentLabel.font = marginContentLabel.font.withSize(12)
        
        usedTitleLabel.backgroundColor = SCColor.clear
        usedTitleLabel.textColor = SCColor.middleBlue
        usedTitleLabel.text = "markets_used".localized
        usedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        usedTitleLabel.font = usedTitleLabel.font.withSize(12)
        
        usedContentLabel.backgroundColor = SCColor.clear
        usedContentLabel.textColor = SCColor.white
        usedContentLabel.text = "$13.17"  // hardcoded
        usedContentLabel.translatesAutoresizingMaskIntoConstraints = false
        usedContentLabel.font = usedContentLabel.font.withSize(12)
    }
    
    func updateContent(equity: String?,
                       balance: String?) {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        if let equityStr = equity, let equityDouble = Double(equityStr) {
            equiryContentLabel.text = currencyFormatter.string(from: NSNumber(value: equityDouble))
        }
        
        if let balanceStr = balance, let balanceDouble = Double(balanceStr)  {
            balanceContentLabel.text = currencyFormatter.string(from: NSNumber(value: balanceDouble))
        }
    }
}
