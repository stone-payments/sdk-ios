//
//  TestValidationViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 21/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class TestValidationViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Testando Validações"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performActivation(_ sender: Any) {
        if (STNValidationProvider.validateActivation()){
            NSLog("Stone Code está ativado!")
            self.feedbackLabel.text = "Stone Code está ativado!"
        }else{
            NSLog("Stone Code não ativado.")
            self.feedbackLabel.text = "Stone Code não ativado."
        }
    }
    
    @IBAction func performPinpadConnection(_ sender: Any) {
        if (STNValidationProvider.validatePinpadConnection()){
            NSLog("O pinpad está pareado com o dispositivo iOS!")
            self.feedbackLabel.text = "O pinpad está pareado com o dispositivo iOS!"
        } else {
            NSLog("O pinpad não pareado com o dispositivo iOS!")
            self.feedbackLabel.text = "O pinpad não pareado com o dispositivo iOS!"
        }
    }
    @IBAction func performTableDownloaded(_ sender: Any) {
        if (STNValidationProvider.validateTablesDownloaded()) {
            NSLog("As tabelas já foram baixadas para o dispositivo iOS!");
            self.feedbackLabel.text = "As tabelas já foram baixadas para o dispositivo iOS!";
        } else {
            NSLog("As tabelas ainda não foram baixadas para o dispositivo iOS!");
            self.feedbackLabel.text = "As tabelas ainda não foram baixadas para o dispositivo iOS!";
        }
    }
    
    @IBAction func performConnectionNetwork(_ sender: Any) {
        if (STNValidationProvider.validateConnectionToNetWork()) {
            NSLog("A conexão com a internet está ativa!");
            self.feedbackLabel.text = "A conexão com a internet está ativa!";
        } else {
            NSLog("A conexão com a internet está inativa!");
            self.feedbackLabel.text = "A conexão com a internet está inativa!";
        }
    }
}
