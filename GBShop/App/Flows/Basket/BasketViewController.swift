//
//  BasketViewController.swift
//  GBShop
//
//  Created by Olga Martyanova on 16/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet var router: BasketRouter!
    var products = [Product]()
    var orderSum = 0
    let metrica = Di.container.resolve(Metrica.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get and show productList data
        let productsListSevice = Di.container.resolve(ProductsListService.self)
        productsListSevice?.getProductsList(pageNumber: 1, idCategory: 1) { [weak self] products in
            if let products = products {
                self?.products = products
                for (index, value) in products.enumerated() {
                   self?.setBasketView(index: index, product: value)
                }
                self?.setTotalView()
            }
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
         router.toExit(controller: self)
    }
    @IBAction func backButton(_ sender: Any) {
        router.toBack(controller: self)
    }
    
    private func setBasketView (index: Int, product: Product) {
        
        if let basketView = Bundle.main.loadNibNamed("BasketView", owner: self, options: nil)?.first as? BasketView {
            
            basketView.deleteButton.layer.borderWidth = 1
            basketView.deleteButton.layer.cornerRadius = 6
            basketView.deleteButton.layer.borderColor = UIColor.init(red: 0.01, green: 0.58, blue: 0.99, alpha: 1.0).cgColor
         //   basketView.layer.borderColor = UIColor.lightGray.cgColor
        //    basketView.layer.borderWidth = 1
            basketView.number.text = String(index + 1)
            basketView.name.text = product.productName
            basketView.quantity.text = "1"
            basketView.price.text = String(product.price)
            basketView.deleteButton.tag = index
            orderSum += product.price
            basketView.deleteButton.addTarget(self, action: #selector(deleteButtonAction(sender:)), for: .touchUpInside)
            self.containerView.addArrangedSubview(basketView)
        }
    }
    
    private func setTotalView () {
        
        if let totalView = Bundle.main.loadNibNamed("TotalView", owner: self, options: nil)?.first as? TotalView {
            totalView.orderButton.layer.cornerRadius = 5
            totalView.sum.text = String(orderSum)
            totalView.orderButton.addTarget(self, action: #selector(orderButtonAction(sender:)), for: .touchUpInside)
            self.containerView.addArrangedSubview(totalView)
        }
    }
    
    @objc func deleteButtonAction(sender: UIButton) {
        
        let index = sender.tag
        orderSum = 0
        products.remove(at: index)
        
        let deleteProductService = Di.container.resolve(DeleteProductService.self)
        deleteProductService?.deleteProduct(idProduct: 123) { [weak self] result in
            if result == 1 {
                self?.successMessage(message: "Товар был удален из корзины!")
                self?.metrica?.log(event: "PRODUCT_WAS_REMOVED_FROM_THE_BASKET",
                                   parameters: ["ID_PRODUCT": "123"])
                Log.log(event: "PRODUCT_WAS_REMOVED_FROM_THE_BASKET", category: Log.network)
            }
        }
        
        for view in containerView.subviews {
            view.removeFromSuperview()
        }
        
        for (index, value) in products.enumerated() {
            setBasketView(index: index, product: value)
        }
        if products.count > 0 {
        setTotalView()
        }
    }
    
    @objc func orderButtonAction (sender: UIButton) {
        
        let orderPaymentService = Di.container.resolve(OrderPaymentService.self)
        orderPaymentService?.orderPayment(idOrder: 123) { [weak self] message in
            if let responseMessage = message {
                self?.metrica?.log(event: "SUCCESSFULL_ORDER_PAYMENT", parameters: ["ID_ORDER": "123"])
                Log.log(event: "SUCCESSFULL_ORDER_PAYMENT", category: Log.network)
                self?.products.removeAll()
                guard let subviews = self?.containerView.subviews else {return}
                for view in subviews {
                    view.removeFromSuperview()
                }
                self?.successMessage(message: responseMessage)
            }
        }
    }
    
    private func successMessage(message: String) {
        
        let alter = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
}
