//
//  RefreshTablesViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 15/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class RefreshTablesViewController: UIViewController {
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Carregamento das Tabelas"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performRefreshTables(_ sender: Any) {
        NSLog("Efetuando Atualização das Tabelas")
        /*
            Atualizamos as tabelas
         */
        feedbackLabel.text = "Carregando..."
        STNTableLoaderProvider.loadTables { (succeeded, error) in
            if succeeded {
                NSLog("Tabelas atualizadas")
                self.feedbackLabel.text = "Tabelas atualizadas"
            } else {
                NSLog(error.debugDescription)
                self.feedbackLabel.text = error.debugDescription
            }
        }
    }
}
