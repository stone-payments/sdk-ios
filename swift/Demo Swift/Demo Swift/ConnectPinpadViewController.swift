//
//  ConnectPinpadViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 15/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ConnectPinpadViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sessão com Pinpad"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performConnectPinpad(_ sender: Any) {
        /*
            Efetuando a conexão com o pinpad;
         */
        self.feedbackLabel.text = "Conectando..."
        STNPinPadConnectionProvider.connect { (succeeded, error) in
            if succeeded {
                NSLog("Conectado com sucesso.")
                self.feedbackLabel.text = "Conectado"
            } else {
                NSLog(error.debugDescription);
                self.feedbackLabel.text = error.debugDescription
            }
        }
    }
}
