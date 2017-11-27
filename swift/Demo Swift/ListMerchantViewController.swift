//
//  ListMerchantViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 20/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ListMerchantViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {

    @IBOutlet weak var merchantTableView: UITableView!
    var merchants: [STNMerchantModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Lista de Lojistas"
        self.merchants = STNMerchantListProvider.listMerchants() as! [STNMerchantModel]
    }

    @IBAction func performListMerchant(_ sender: Any) {
        self.merchants = STNMerchantListProvider.listMerchants() as! [STNMerchantModel]
        self.merchantTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.merchants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MerchantCell", for: indexPath) as! MerchantTableViewCell
        let merchant: STNMerchantModel = self.merchants[indexPath.row]
        
        cell.nameLabel.text = merchant.merchantName
        cell.documentLabel.text = merchant.documentNumber
        cell.affiliationLabel.text = merchant.saleAffiliationKey
        
        return cell
    }

}
