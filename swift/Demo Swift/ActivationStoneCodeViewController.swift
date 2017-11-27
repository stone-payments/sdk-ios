//
//  ActivationStoneCodeViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 15/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ActivationStoneCodeViewController: UIViewController {

    @IBOutlet weak var stoneCodeTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Ativar Stone Code"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performActivation(_ sender: Any) {
        NSLog("Ativando Stone Code")
        let stoneCode: String = self.stoneCodeTextField.text!
        /*
            Efetuando ativação do Stone Code;
         */
        STNStoneCodeActivationProvider.activateStoneCode(stoneCode) { (succeeded, error) in
            if succeeded {
                NSLog("Stone Code Ativado com Sucesso.")
                self.feedbackLabel.text = "Stone Code Ativado com Sucesso."
            } else {
                NSLog(error.debugDescription)
                self.feedbackLabel.text = error.debugDescription
            }
        }
    }
    
    @IBAction func performDeactivation(_ sender: Any) {
        NSLog("Desativando Stone Code")
        let stoneCode: String = self.stoneCodeTextField.text!
        /*
            Efetuando a Desativação do Stone Code;
         */
        STNStoneCodeActivationProvider.deactivateMerchant(withStoneCode: stoneCode)
        NSLog("Desativação realizada com sucesso.")
        self.feedbackLabel.text = "Desativação realizada com sucesso."
    }
}
