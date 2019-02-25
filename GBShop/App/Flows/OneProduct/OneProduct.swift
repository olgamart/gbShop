//
//  OneProduct.swift
//  GBShop
//
//  Created by Olga Martyanova on 14/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import UIKit

class OneProduct: UIView {
    
    @IBOutlet var productContainer: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    init(frame: CGRect, arg1: CGFloat, arg2: String) {
        super.init(frame: frame)
        configure()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed("OneProduct", owner: self, options: nil)
        addSubview(productContainer)
        productContainer.frame = self.bounds
        productContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        buyButton.layer.cornerRadius = 5
    }
   
}
