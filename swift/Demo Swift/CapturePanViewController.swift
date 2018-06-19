//
//  CapturePanViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 21/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class CapturePanViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Captura de PAN"
        
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performCapture(_ sender: Any)
    {
        self.loadingView.show()
        STNCardProvider.getCardPan(
        { (succeeded, pan, error) in
            DispatchQueue.main.async
            {
                if succeeded
                {
                    self.feedbackLabel.text = "**** **** **** \(pan ?? "erro")"
                }
                else
                {
                    self.feedbackLabel.text = error.debugDescription
                }
                self.loadingView.hide()
            }
        })
    }
}
