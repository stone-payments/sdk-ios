//
//  CancelListTransaction.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 20/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class CancelListTransactionViewController: UITableViewController {
    
    var transactions: [STNTransactionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Cancelar Transações"

        self.transactions = STNTransactionListProvider.listTransactions() as! [STNTransactionModel]
        
        print("Transaction: \(transactions.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CancelTransactionCell", for: indexPath) as! CancelTransactionTableViewCell
        
        let transaction: STNTransactionModel = self.transactions[indexPath.row] as STNTransactionModel

        // Tratando o valor do Amount;
        let centsValue: Int = (transaction.amount?.intValue)!
        let taxPercentage = 0.01
        let realValue = Double(centsValue) * taxPercentage
        let amount = String(format: "%.02f", realValue)
        
        cell.amountLabel.text = String(format:"%@ %@", "R$", amount)
        
        // Tratamento do valor Status;
        let shortStatus: String
        if transaction.statusString == "Transação Aprovada" {
            shortStatus = "Aprovado"
        }else if transaction.statusString == "Transação Cancelada" {
            shortStatus = "Cancelada"
        } else {
            shortStatus = transaction.statusString
        }
        cell.statusLabel.text = shortStatus
        
        // Tratando do valor da Data;
        cell.dateLabel.text = transaction.dateString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueCancelTransation", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cancelationVC: CancelationTransactionViewController = segue.destination as! CancelationTransactionViewController;
        cancelationVC.transaction = self.transactions[(self.tableView.indexPathForSelectedRow?.row)!]
    }


}
