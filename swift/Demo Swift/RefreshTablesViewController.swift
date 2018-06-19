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
    
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Carregamento das Tabelas"
        
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performRefreshTables(_ sender: Any) {
        /*
            Atualizamos as tabelas
         */
        feedbackLabel.text = "Carregando..."
        self.loadingView.show()
        
        STNTableLoaderProvider.loadTables
        { (succeeded, error) in
            DispatchQueue.main.async()
            {
                if succeeded
                {
                    self.feedbackLabel.text = "Tabelas atualizadas"
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
