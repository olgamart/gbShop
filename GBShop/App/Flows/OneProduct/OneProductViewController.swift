//
//  OneProductViewController.swift
//  GBShop
//
//  Created by Olga Martyanova on 14/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

class OneProductViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var productView: OneProduct!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var router: OneProductRouter!
    
    var user: User?
     var addReview = AddReview()
    let metrica = Di.container.resolve(Metrica.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        //Get and show product data
        let productSevice = Di.container.resolve(ProductService.self)
        
        productSevice?.getProduct(idProduct: 123) { [weak self] product in
            if let product = product {
                self?.productView.productName.text = product.productName
                self?.productView.productDescription.text = product.productDescription
                self?.productView.productPrice.text = String(product.productPrice)
                self?.metrica?.log(event: "SINGLE_PRODUCT_WAS_OPENED", parameters: ["ID_PRODUCT": "123"])
                Log.log(event: "SINGLE_PRODUCT_WAS_OPENED", category: Log.network)
            }
        }
        
        //Get and show list of reviews
        let reviewsListService = Di.container.resolve(ReviewsListService.self)
        reviewsListService?.getReviewsList(idProduct: 123) { [weak self] reviews in
            if let reviews = reviews {
                for review in reviews {
                    self?.setView(review: review)
                }
                self?.setAddReview()
            }
        }
        
        productView.buyButton.addTarget(self, action: #selector(buyButtonAction(sender:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setAddReview() {
        if let view = Bundle.main.loadNibNamed("AddReview", owner: self, options: nil)?.first as? AddReview {
            addReview = view
            addReview.textView.layer.borderColor = UIColor.lightGray.cgColor
            addReview.textView.layer.borderWidth = 1
            addReview.textView.layer.cornerRadius = 6
            addReview.addReviewButton.layer.cornerRadius = 5
            addReview.addReviewButton.addTarget(self, action: #selector(buttonAddReviewAction(sender:)), for: .touchUpInside)
            containerView.addArrangedSubview(addReview)
        }
    }
    
    private func setView (review: Review) {
        if let reviewView = Bundle.main.loadNibNamed("ProductReview", owner: self, options: nil)?.first as? ProductReview {
            reviewView.name.text = review.userName
            reviewView.review.text = review.text
            containerView.addArrangedSubview(reviewView)
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
         router.toExit(controller: self)
    }
    @IBAction func backButton(_ sender: Any) {
        router.toProductList(controller: self)
    }
    
    @IBAction func basketButton(_ sender: Any) {
            router.toBasket()
    }
    
    @IBAction func personDataButton(_ sender: Any) {
        if let user = user {
            router.toUserData(user: user)
        }
    }
    
    @objc func buyButtonAction(sender: UIButton) {
        
        //Add product to the basket
        let addProductService = Di.container.resolve(AddProductService.self)
        addProductService?.addProduct(idProduct: 123, quantity: 1) { [weak self] message in
            if let responseMessage = message {
                self?.metrica?.log(event: "PRODUCT_WAS_ADDED_TO_THE_BASKET", parameters: ["ID_PRODUCT": "123",
                                                                                          "QUANTITY": "1"])
                Log.log(event: "PRODUCT_WAS_ADDED_TO_THE_BASKET", category: Log.network)
                self?.successMessage(message: responseMessage)
            }
        }
    }
    
    @objc func buttonAddReviewAction(sender: UIButton) {
        if addReview.textView.text != "" {
            //Add new review
            let reviewService = Di.container.resolve(ReviewService.self)
            let newReview = Review(idProduct: 123, idUser: 255, userName: "Guest", text: addReview.textView.text)
            reviewService?.addReview(review: newReview) { [weak self] message in
                if let responseMessage = message {
                    self?.successMessage(message: responseMessage)
                    self?.addReview.textView.text = ""
                    self?.metrica?.log(event: "NEW_REVIEW_WAS_ADDED", parameters: ["ID_PRODUCT": "123",
                                                                                   "ID_USER": "255"])
                    Log.log(event: "NEW_REVIEW_WAS_ADDED", category: Log.network)
                }
            }
        }
    }
    
    private func successMessage(message: String) {
        
        let alter = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        self.scrollView?.endEditing(true)
        present(alter, animated: true, completion: nil)
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbValue = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        guard let kbSize = kbValue else {return}
        
        let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: kbSize.cgRectValue.size.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        scrollView?.contentOffset.y += kbSize.cgRectValue.size.height
        
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        scrollView?.contentOffset.y = 0
    }
    
    @objc private func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}
