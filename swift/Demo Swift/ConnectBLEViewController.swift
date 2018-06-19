//
//  ConnectBLEViewController.swift
//  Demo Swift
//
//  Created by Kennedy Noia | Stone on 31/01/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit
import StoneSDK

class ConnectBLEViewController: UIViewController, STNPinPadConnectionDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedback: UILabel!
    
    var loadingView: LoadingView!
    
    var peripherals = [STNPinpad]()
    var connection: STNPinPadConnectionProvider!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Set loading overlay view
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView)
        
        connection = STNPinPadConnectionProvider.init()
        connection.delegate = self
        connection.startCentral()
    }
    
    // MARK: Buttons actions
    @IBAction func startScanning(_ sender: Any) {
        connection.startScan()
    }
    
    @IBAction func disconnectAllBLE(_ sender: Any) {
        let connectedPinpads = connection.listConnectedPinpads()
        
        connectedPinpads.forEach { pinpad in
            connection.disconnectPinpad(pinpad)
        }
    }
    
    // MARK: Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peripheralCell", for: indexPath)
        cell.textLabel?.text = peripherals[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        connection.connect(to: peripherals[indexPath.row])
        connection.stopScan()
        setFeedback(message: "Conectado com \(peripherals[indexPath.row].name)")
    }
    
    // MARK: Pinpad Connection Delegate
    func pinpadConnectionProvider(_ provider: STNPinPadConnectionProvider, didStartScanning success: Bool, error: Error?) {
        setFeedback(message: "Começou a escanear")
    }
    
    func pinpadConnectionProvider(_ provider: STNPinPadConnectionProvider, didFind pinpad: STNPinpad) {
        if peripherals.contains(pinpad) == false
        {
            peripherals.append(pinpad)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func pinpadConnectionProvider(_ provider: STNPinPadConnectionProvider,
                                  didConnect pinpad: STNPinpad, error: Error?) {
        connection.select(pinpad)
        self.setFeedback(message: "Conectou a pinpad")
    }
    
    func pinpadConnectionProvider(_ provider: STNPinPadConnectionProvider,
                                  didDisconnectPinpad pinpad: STNPinpad) {
        setFeedback(message: "Desconectou de pinpad")
    }
    
    func pinpadConnectionProvider(_ provider: STNPinPadConnectionProvider,
                                  didChangeCentralState state: CBManagerState) {
        var stateString = ""
        
        
        
        switch state {
        case .unknown:
            stateString = "Unknown"
            break
        case .resetting:
            stateString = "Resetting"
            break
        case .unsupported:
            stateString = "Unsupported"
            break
        case .unauthorized:
            stateString = "Unauthorized"
            break
        case .poweredOff:
            stateString = "Powered off"
            break
        case .poweredOn:
            stateString = "Powered on"
            break
        }
        print("Central state", stateString)
    }
    
    func setFeedback(message: String) {
        DispatchQueue.main.async {
            self.feedback.text = message
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
