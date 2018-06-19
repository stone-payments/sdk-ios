//
//  CancelationTransactionViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 20/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class CancelationTransactionViewController: UIViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var feedback: UILabel!
    
    var loadingView: LoadingView!
    var transaction: STNTransactionModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Cancelar Transação"
        
        //Set loading overlay view
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView)
        
        // Tratando o valor do Amount;
        let centsValue: Int = (transaction.amount?.intValue)!
        let taxPercentage = 0.01
        let realValue = Double(centsValue) * taxPercentage
        let amount = String(format: "%.02f", realValue)
        
        self.amountLabel.text = String(format:"%@ %@", "R$", amount)
        
        // Tratamento do valor Status;
        let shortStatus: String
        if transaction.statusString == "Transação Aprovada" {
            shortStatus = "Aprovado"
        }else if transaction.statusString == "Transação Cancelada" {
            shortStatus = "Cancelada"
        } else {
            shortStatus = transaction.statusString
        }
        self.statusLabel.text = shortStatus
        
        // Tratando do valor da Data;
        self.dateLabel.text = transaction.dateString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performCancelation(_ sender: Any)
    {
        self.loadingView.show()
        STNCancellationProvider.cancelTransaction(self.transaction)
        { (succeeded, error) in
            DispatchQueue.main.async
            {
                if succeeded
                {
                    self.feedback.text = "Transação cancelada"
                }
                else
                {
                    self.feedback.text = error.debugDescription
                }
                self.loadingView.hide()
            }
        }
    }
}
