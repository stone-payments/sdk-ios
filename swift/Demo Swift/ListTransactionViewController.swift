//
//  ListTransactionViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 17/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ListTransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var typeTransaction: UISegmentedControl!
    var transactions: [STNTransactionModel] = []
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Lista de Transações"
        self.transactions = STNTransactionListProvider.listTransactions() as! [STNTransactionModel]
        
        //Set loading overlay view
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView)
    }

    @IBAction func listTransaction(_ sender: Any)
    {
        switch self.typeTransaction.selectedSegmentIndex
        {
        case 0:
            // Listar todas as transacoes
            self.transactions = STNTransactionListProvider.listTransactions() as! [STNTransactionModel]
            self.transactionTableView.reloadData()
            break
        case 1:
            // Listar transacoes de um cartao
            STNTransactionListProvider.listTransactions(byPan:
            { (succeeded, transactionsList, error) in
                if succeeded
                {
                    // Atualizando a table view
                    self.transactions = transactionsList as! [STNTransactionModel]
                    self.transactionTableView.reloadData()
                }
                else
                {
                    print(error.debugDescription)
                }
            })
            break
        default: break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
        
        let transactionInfoProvider: STNTransactionModel = self.transactions[indexPath.row]
        
        // Tratando o valor do Amount;
        let centsValue: Int = (transactionInfoProvider.amount?.intValue)!
        let taxPercentage = 0.01
        let realValue = Double(centsValue) * taxPercentage
        let amount = String(format: "%.02f", realValue)
        
        cell.amountLabel.text = String(format:"%@ %@", "R$", amount)
        
        // Tratamento do valor Status;
        let shortStatus: String
        if transactionInfoProvider.statusString == "Transação Aprovada" {
            shortStatus = "Aprovado"
        }else if transactionInfoProvider.statusString == "Transação Cancelada" {
            shortStatus = "Cancelada"
        } else {
            shortStatus = transactionInfoProvider.statusString
        }
        cell.statusLabel.text = shortStatus
        
        // Tratando do valor da Data;
        cell.dateLabel.text = transactionInfoProvider.dateString
        
        return cell
    }
}
