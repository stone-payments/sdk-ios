//
//  ConnectPinpadViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 15/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class SelectPinpadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var loadingView: LoadingView!
    
    var connectedPinpads: [STNPinpad]!
    var pinpadConnectionProvider = STNPinPadConnectionProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sessão com Pinpad"
        
        //Set loading overlay view
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
        
        connectedPinpads = []
        self.loadingView.show()
        
        DispatchQueue.main.async()
        {
            self.findConnectedPinpads()
            
            let selectedPinpad = STNPinPadConnectionProvider().selectedPinpad()
            var i = 0
            for pinpad in self.connectedPinpads {
                if selectedPinpad != nil && pinpad.name == selectedPinpad?.name
                {
                    self.tableView.selectRow(at: IndexPath.init(row: i, section: 0),
                                        animated: false,
                                        scrollPosition: UITableViewScrollPosition.top)
                    i += 1
                    self.feedbackLabel.text = "Selected pinpad \(pinpad.name)"
                }
            }
            self.loadingView.hide()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func findConnectedPinpads () {
        connectedPinpads = STNPinPadConnectionProvider().listConnectedPinpads()
        for pinpad in connectedPinpads {
            print("Pinpad name: \(pinpad.name) Pinpad identifier: \(pinpad.identifier)")
        }
        print(self.connectedPinpads);
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pinpadCell",
                                                 for: indexPath)
        let pinpad = connectedPinpads[indexPath.row]
        cell.textLabel?.text = pinpad.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPinpad = connectedPinpads[indexPath.row]
        
        
        for i in 0..<1
        {
            self.loadingView.show()
            
            if self.pinpadConnectionProvider.isPinpadConnected(selectedPinpad) == false
            {
                self.pinpadConnectionProvider.connect(to: selectedPinpad)
            }
            self.pinpadConnectionProvider.select(selectedPinpad)
            if self.pinpadConnectionProvider.isPinpadConnected(selectedPinpad)
            {
                DispatchQueue.main.async()
                    {
                        self.feedbackLabel.text = "Selected pinpad \(selectedPinpad.name) - \(selectedPinpad.identifier)"
                }
            }
            else
            {
                DispatchQueue.main.async()
                    {
                        self.feedbackLabel.text = "Unable to select pinpad."
                }
            }
            print("Try to select device number: \(i)")
            self.loadingView.hide()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectedPinpads.count
    }
    
    
    @IBAction func findPinpadsAndRefreshList(_ sender: Any) {
        self.loadingView.show()
        
        DispatchQueue.main.async()
        {
            self.findConnectedPinpads()
            self.loadingView.hide()
        }
    }
}
