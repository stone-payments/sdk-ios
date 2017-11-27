//
//  SendingVoucherEmailViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 21/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class SendingVoucherEmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Envio por E-mail"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performSendingVoucher(_ sender: Any) {
        var transactions = STNTransactionListProvider.listTransactions()
        if ((transactions?.count)! > 0) {
            let destination = self.emailTextField.text;
            self.feedbackLabel.text = "Preparando para enviar..."
            STNMailProvider.sendReceipt(viaEmail: STNMailTemplateTransaction, transaction: transactions?[0] as! STNTransactionModel, toDestination: destination, displayCompanyInformation: true, with: { (succeeded, error) in
                if succeeded {
                    NSLog("E-mail enviado com sucesso.")
                    self.feedbackLabel.text = "E-mail enviado com sucesso."
                } else {
                    NSLog("$@", error.debugDescription)
                    self.feedbackLabel.text = error.debugDescription
                }
            })
        } else {
            NSLog("Efetue ao menos uma transação")
            self.feedbackLabel.text = "Efetue ao menos uma transação"
        }
    }
}
