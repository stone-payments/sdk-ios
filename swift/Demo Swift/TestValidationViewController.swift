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
    
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Testando Validações"
        
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performActivation(_ sender: Any) {
        self.loadingView.show()
        DispatchQueue.main.async
        {
            if (STNValidationProvider.validateActivation())
            {
                self.feedbackLabel.text = "Stone Code está ativado!"
            }
            else
            {
                self.feedbackLabel.text = "Stone Code não ativado."
            }
            self.loadingView.hide()
        }
    }
    
    @IBAction func performPinpadConnection(_ sender: Any)
    {
        self.loadingView.show()
        DispatchQueue.main.async
        {
            if (STNValidationProvider.validatePinpadConnection())
            {
                self.feedbackLabel.text = "O pinpad está pareado com o dispositivo iOS!"
            }
            else
            {
                self.feedbackLabel.text = "O pinpad não pareado com o dispositivo iOS!"
            }
            self.loadingView.hide()
        }
    }
    
    @IBAction func performTableDownloaded(_ sender: Any) {
        self.loadingView.show()
        DispatchQueue.main.async
        {
            if (STNValidationProvider.validateTablesDownloaded())
            {
                self.feedbackLabel.text = "As tabelas já foram baixadas para o dispositivo iOS!";
            }
            else
            {
                self.feedbackLabel.text = "As tabelas ainda não foram baixadas para o dispositivo iOS!";
            }
            self.loadingView.hide()
        }
    }
    
    @IBAction func performConnectionNetwork(_ sender: Any) {
        self.loadingView.show()
        DispatchQueue.main.async
        {
            if (STNValidationProvider.validateConnectionToNetWork())
            {
                self.feedbackLabel.text = "A conexão com a internet está ativa!";
            }
            else
            {
                self.feedbackLabel.text = "A conexão com a internet está inativa!";
            }
            self.loadingView.hide()
        }
    }
}
