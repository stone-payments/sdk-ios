//
//  PerformTransactionViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 15/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class PerformTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var instalmentPicker: UIPickerView!
    @IBOutlet weak var transactionTypeSegmented: UISegmentedControl!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateSwitch: UISwitch!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    var pickerMenu: [String] = []
    var rowNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Realizar Transação"
        self.pickerMenu = ["À Vista", "2 Parcelas", "3 Parcelas", "4 Parcelas", "5 Parcelas", "6 Parcelas",
                           "7 Parcelas", "8 Parcelas", "9 Parcelas", "10 Parcelas", "11 Parcelas", "12 Parcelas"]
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        self.instalmentPicker.dataSource = self
        self.instalmentPicker.delegate = self
        self.instalmentPicker.isHidden = true
        self.rateSwitch.isHidden = true
        self.rateLabel.isHidden = true
        self.valueTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onOrOff(_ sender: Any) {
        if self.rateSwitch.isOn {
            NSLog("Com Juros")
            self.rateLabel.text = "Com Juros"
        } else {
            NSLog("Sem Juros")
            self.rateLabel.text = "Sem Juros"
        }
    }
    
    @IBAction func changeType(_ sender: Any) {
        switch self.transactionTypeSegmented.selectedSegmentIndex {
        case 0:
            NSLog("Débito")
            self.instalmentPicker.isHidden = true
            self.rateSwitch.isHidden = true
            self.rateLabel.isHidden = true
            break
        case 1:
            NSLog("Crédito")
            self.instalmentPicker.isHidden = false
            self.rateSwitch.isHidden = false
            self.rateLabel.isHidden = false
            break
        default:
            break
        }
    }
    

    @IBAction func performTransaction(_ sender: Any) {
        
        NotificationCenter.default.addObserver(self, selector: Selector(("handNotification")), name: NSNotification.Name(rawValue: PINPAD_MESSAGE), object: nil)

        let valueString = String(describing: valueTextField.text)
        let justCents = Int(valueString.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined())
        let transaction: STNTransactionModel = STNTransactionModel.init()
        
        if let justCents = justCents {
            // Propriedade Obrigatória, deve conter o valor da transação em centavos. (EX. R$ 56,45 = 5645);
            transaction.amount = NSNumber.init(value: justCents)
        }
        
        // Propriedade Obrigatória, define o tipo de parcelamento, com juros, sem juros, pagamento a vista;
        transaction.instalmentType = STNInstalmentTypeNone

        if self.transactionTypeSegmented.selectedSegmentIndex == 0 { // É Débito
            
            // Propriedade Obrigatória, define o tipo de transação, se é débito ou crédito;
            transaction.type = STNTransactionTypeSimplifiedDebit
            
            // Propriedade Obrigatória, define o número de parcelas da transação;
            transaction.instalmentAmount = STNTransactionInstalmentAmountOne
            
        } else { // É Crédito
            
            // Propriedade Obrigatória, define o tipo de transação, se é débito ou crédito;
            transaction.type = STNTransactionTypeSimplifiedCredit
            
            // Propriedade Obrigatória, define o número de parcelas da transação;
            switch self.rowNumber {
                case 0: transaction.instalmentAmount = STNTransactionInstalmentAmountOne; break
                case 1: transaction.instalmentAmount = STNTransactionInstalmentAmountTwo; break
                case 2: transaction.instalmentAmount = STNTransactionInstalmentAmountThree; break
                case 3: transaction.instalmentAmount = STNTransactionInstalmentAmountFour; break
                case 4: transaction.instalmentAmount = STNTransactionInstalmentAmountFive; break
                case 5: transaction.instalmentAmount = STNTransactionInstalmentAmountSix; break
                case 6: transaction.instalmentAmount = STNTransactionInstalmentAmountSeven; break
                case 7: transaction.instalmentAmount = STNTransactionInstalmentAmountEight; break
                case 8: transaction.instalmentAmount = STNTransactionInstalmentAmountNine; break
                case 9: transaction.instalmentAmount = STNTransactionInstalmentAmountTen; break
                case 10: transaction.instalmentAmount = STNTransactionInstalmentAmountEleven; break
                case 11: transaction.instalmentAmount = STNTransactionInstalmentAmountTwelve; break
            default:
                break
            }
        }
        
        // Vamos efetivar a transação;
        STNTransactionProvider.sendTransaction(transaction) { (succeeded, error) in
            if succeeded {
                NSLog("Transação realizada com sucesso.")
                self.feedbackLabel.text = "Transação OK"
            } else {
                NSLog(error.debugDescription)
                self.feedbackLabel.text = error.debugDescription
            }
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: PINPAD_MESSAGE), object: nil)
        }
    }
    
    func handleNotification(notification: Notification)
    {
        let notificationString: String = notification.object as! String
        print("Mensagem do Pinpad \(notificationString)")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxDigits = 13
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        
        var stringMaybeChanged = NSString.init(string: string)
        
        if stringMaybeChanged.length > 1 {
            
            let stringPasted = NSMutableString.init(string: stringMaybeChanged)
            
            stringPasted.replaceOccurrences(of: numberFormatter.currencySymbol, with: "", options: .literal, range: NSMakeRange(0, stringPasted.length))
            
            stringPasted.replaceOccurrences(of: numberFormatter.groupingSeparator, with: "", options: .literal, range: NSMakeRange(0, stringPasted.length))
            
            let numberPasted = NSDecimalNumber.init(string: stringPasted as String)
            stringMaybeChanged = numberFormatter.string(from: numberPasted as NSNumber)! as NSString
        }
        
        let selectedRange = textField.selectedTextRange
        let start = textField.beginningOfDocument
        let cursorOffset = textField.offset(from: start, to: (selectedRange?.start)!)
        let textFieldTextStr = NSMutableString.init(string: textField.text!)
        let textFieldTextStrLength = textFieldTextStr.length
        
        textFieldTextStr.replaceCharacters(in: range, with: stringMaybeChanged as String)
        textFieldTextStr.replaceOccurrences(of: numberFormatter.currencySymbol, with: "", options: .literal, range: NSMakeRange(0, textFieldTextStr.length))
        textFieldTextStr.replaceOccurrences(of: numberFormatter.groupingSeparator, with: "", options: .literal, range: NSMakeRange(0, textFieldTextStr.length))
        textFieldTextStr.replaceOccurrences(of: numberFormatter.decimalSeparator, with: "", options: .literal, range: NSMakeRange(0, textFieldTextStr.length))
        
        if textFieldTextStr.length <= maxDigits {
            
            let textFieldTextNum = NSDecimalNumber.init(string: textFieldTextStr as String)
            let divideByNum = NSDecimalNumber.init(value: 10).raising(toPower: numberFormatter.maximumFractionDigits)
            let textFieldTextNewNum = textFieldTextNum.dividing(by: divideByNum)
            var textFieldTextNewStr = numberFormatter.string(from: textFieldTextNewNum)
            
            textField.text = textFieldTextNewStr
            
            if cursorOffset != textFieldTextStrLength {
                
                let lengthDelta = (textFieldTextNewStr?.characters.count)! - textFieldTextStrLength
                let newCursosOffset = max(0, min((textFieldTextNewStr?.characters.count)!, cursorOffset + lengthDelta))
                let newPosition = textField.position(from: textField.beginningOfDocument, offset: newCursosOffset)
                
                let newRange = textField.textRange(from: newPosition!, to: newPosition!)
                
                textField.selectedTextRange = newRange
                
            }
        }
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerMenu.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerMenu[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowNumber = row
    }
    
    
    
}
