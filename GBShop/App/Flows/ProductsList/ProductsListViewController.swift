//
//  ProductsListViewController.swift
//  GBShop
//
//  Created by Olga Martyanova on 11/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

class ProductsListViewController: UITableViewController {
    
    @IBOutlet var router: ProductsListRouter!
    var user: User?
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let productsListSevice = Di.container.resolve(ProductsListService.self)
        let metrica = Di.container.resolve(Metrica.self)
        
        productsListSevice?.getProductsList(pageNumber: 1, idCategory: 1) { [weak self] products in
            if let products = products {
                self?.products = products
                self?.tableView.reloadData()
                metrica?.log(event: "PRODUCTS_LIST_WAS_OPENED")
                Log.log(event: "PRODUCTS_LIST_WAS_OPENED", category: Log.network)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell", for: indexPath) as? ProductViewCell
         cell?.setup(with: product)
        return cell ?? UITableViewCell()
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        if let user = user {
            router.toOneProduct(user: user)
        }
    }
  
    @IBAction func exitButton(_ sender: Any) {
         router.toExit(controller: self)
    }
    @IBAction func basketButton(_ sender: Any) {
            router.toBasket()
    }
    
    @IBAction func personDataButton(_ sender: Any) {
        if let user = user {
            router.toUserData(user: user)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        router.toLogin(controller: self)
    }
}
