//
//  SendingVoucherEmailViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 21/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class SendingVoucherEmailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet var transactionsTableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var transactions: [STNTransactionModel]!
    var selectedTransaction: STNTransactionModel?
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Envio por E-mail"
        
        //Set loading overlay view
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView)
        
        //get all transaactions
        self.transactions = (STNTransactionListProvider.listTransactions() as! [STNTransactionModel])

        if self.transactions.count > 0 {
            self.selectedTransaction = self.transactions.first!
            self.transactionsTableView.selectRow(at: IndexPath.init(row: 0, section: 0),
                                                 animated: false,
                                                 scrollPosition: UITableViewScrollPosition.top)
        }
        
        self.transactionsTableView.delegate = self
        self.transactionsTableView.dataSource = self
        
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performSendingVoucher(_ sender: Any)
    {
        NSLog("outside")
        if (self.selectedTransaction != nil) && (self.transactions.contains(self.selectedTransaction!))
        {
            NSLog("inside")
            self.loadingView.show()
            let destination = self.emailTextField.text;
            self.feedbackLabel.text = "Preparando para enviar..."
        
            let receiptType: STNReceiptType;
            if self.segmentedControl.selectedSegmentIndex == 0
            {
                receiptType = STNReceiptTypeMerchant
            }
            else
            {
                receiptType = STNReceiptTypeCustomer
            }
            let receiptModel = STNReceiptModel()
            receiptModel.type = receiptType
            receiptModel.transaction = self.selectedTransaction
            receiptModel.displayCompanyInformation = true
            
            let fromContactModel = STNContactModel()
            fromContactModel.name = "Demontração de envio"
            let toContactModel = STNContactModel()
            toContactModel.address = destination
            
            STNMailProvider.sendReceipt(viaEmail: receiptModel,
                                        from: fromContactModel,
                                        to: toContactModel,
                                        with: { (success, error) in
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    if success
                    {
                        NSLog("success")
                        self.feedbackLabel.text = "Comprovante enviado com sucesso!"
                    }
                    else
                    {
                        NSLog("error \(error)")
                        self.feedbackLabel.text = "Falha no envio do comprovante."
                    }
                }
            })
        }
        else
        {
            self.feedbackLabel.text = "Transação não selecionada.";
        }
        NSLog("end")
    }
    
    //    Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.transactions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionsTableView.dequeueReusableCell(withIdentifier: "TransCell", for: indexPath) as! TransactionTableViewCell
        if (self.transactions.count >= indexPath.row )
        {
            // Tratamento do amount somente para exibição.
            let transactionModel = self.transactions[indexPath.row]
            let centsValue = transactionModel.amount?.intValue
            let realValue = Float(centsValue!) * 0.01
            let amount = String(format: "%.02f", realValue)
            cell.amountLabel.text = String(format: "R$ %@", amount)
            
            // Tratamento do status.
            var shortStatus: String
            switch transactionModel.status {
            case STNTransactionStatusApproved:
                shortStatus = "Aprovada"
            case STNTransactionStatusCancelled:
                shortStatus = "Cancelada"
            default:
                shortStatus = "Desconhecida"
            }
            cell.statusLabel.text = shortStatus
            cell.dateLabel.text = transactionModel.dateString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTransaction = self.transactions[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
