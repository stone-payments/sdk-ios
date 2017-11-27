//
//  SearchLowEnergyDevicesTableViewController.swift
//  Demo Swift
//
//  Created by JGabrielFreitas on 17/08/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import CoreBluetooth

class SearchLowEnergyDevicesTableViewController: UITableViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    let FOUR_SECONDS = 4.0
    var manager: CBCentralManager!
    var devices : [String] = []
    @IBOutlet weak var lowEnergyDevicesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Busca LE Devices"
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "simpleTableViewCell")
        cell.textLabel?.text = devices[indexPath.row]
        return cell
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        if central.state == .poweredOn{
            manager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        
        didReadPeripheral(peripheral, rssi: RSSI)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        
        didReadPeripheral(peripheral, rssi: RSSI)
        
        delay(FOUR_SECONDS){
            peripheral.readRSSI()
        }
    }
    
    func didReadPeripheral(_ peripheral: CBPeripheral, rssi: NSNumber){
        
        if let name = peripheral.name{
            
            if !self.devices.contains(name) {
                self.devices.append(name)
                tableView.reloadData()
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        peripheral.readRSSI()
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

}
