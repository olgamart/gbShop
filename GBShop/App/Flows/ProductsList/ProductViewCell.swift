//
//  ProductViewCell.swift
//  GBShop
//
//  Created by Olga Martyanova on 11/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

class ProductViewCell: UITableViewCell {

    @IBOutlet weak var productNameTextField: UILabel!
    @IBOutlet weak var productPriceTextField: UILabel!
    
    func setup (with product: Product) {
        productNameTextField.text = product.productName
        productPriceTextField.text = String(product.price)
    }
}
