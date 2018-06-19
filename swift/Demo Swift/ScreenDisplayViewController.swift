//
//  ScreenDisplayViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 21/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ScreenDisplayViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Exibe mensagem no display"
        
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performDisplayMessage(_ sender: Any) {
        self.loadingView.show()
        let message = self.messageTextField.text
        STNDisplayProvider.displayMessage(message)
        { (succeeded, error) in
            // UI Manipulation code
            DispatchQueue.main.async
            {
                if succeeded
                {
                    self.feedbackLabel.text = "Mensagem enviada ao Pinpad"
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
