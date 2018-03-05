//
//  ViewController.swift
//  Xiaomi Band
//
//  Created by Miguel Mexicano on 18/10/17.
//  Copyright © 2017 Miguel Mexicano. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBCentralManagerDelegate,CBPeripheralDelegate {
    
    
    var manager: CBCentralManager!
    var periferico: CBPeripheral!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a FileManager instance
        

        /*let dirs  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
            let dir = dirs[0] //documents directory
            //let path = dir.stringByAppendingPathComponent(file);
            let path = dir
        
            print(path)*/
        
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let dirContents = try? fileManager.contentsOfDirectory(atPath: documentsPath)
        let count = dirContents?.count
        
        
        print(count)
        
            
            
            
        manager  = CBCentralManager.init(delegate: self, queue: nil)
            
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("perifericos: \(peripheral)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("perifericos: \(peripheral)")
        
        if peripheral.identifier.uuidString == "E177AFDA-DFBA-E038-47C4-24DA13E262C1"
        {
            self.manager.connect(self.periferico, options: nil)
            
        }
        
        
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        manager.stopScan()
        self.periferico.delegate = self
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var consoleMsg = ""
        
        switch central.state {
        case .poweredOff:
            consoleMsg = "Bluetho off"
        case .poweredOn:
            consoleMsg = "Bluetho on"
            manager.scanForPeripherals(withServices: nil, options: nil)
        case .resetting:
            consoleMsg = "Bluetho resetting"
        case .unauthorized:
            consoleMsg = "Bluetho unauthorization"
        case .unknown:
            consoleMsg = "Bluetho unknown"
        case .unsupported:
            consoleMsg = "Bluetho unsupported"
        }
        
               print(consoleMsg)
    }


}

