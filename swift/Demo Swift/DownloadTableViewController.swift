//
//  DownloadTableViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 15/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class DownloadTableViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.title = "Download de Tabelas"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performDownload(_ sender: Any) {
        NSLog("Efetuando Download das Tabelas")
        /*
            Efetuando o download das tabelas
         */
        feedbackLabel.text = "Carregando..."
        STNTableDownloaderProvider.downLoadTables { (succeeded, error) in
            if succeeded {
                NSLog("Download realizado com sucesso.")
                self.feedbackLabel.text = "Download Realizado"
            } else {
                NSLog(error.debugDescription)
                self.feedbackLabel.text = error.debugDescription
            }
        }
    }
}
