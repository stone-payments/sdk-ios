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
    
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Download de Tabelas"
        
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performDownload(_ sender: Any) {
        /*
            Efetuando o download das tabelas
         */
        feedbackLabel.text = "Carregando..."
        self.loadingView.show()
        
        STNTableDownloaderProvider.downLoadTables { (succeeded, error) in
            DispatchQueue.main.async {
                if succeeded
                {
                    self.feedbackLabel.text = "Download Realizado"
                }
                else
                {
                    self.feedbackLabel.text = error.debugDescription
                }
                self.loadingView.hide()
            }
        }
    }
}
