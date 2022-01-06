//
//  Model.swift
//  project2021
//
//  Created by Malin Lehander on 2021-12-20.
//
import Foundation
import CoreBluetooth
import UIKit

struct measurementObject: Identifiable, Codable, Equatable {

    var id: String = UUID().uuidString
    var date: String
    var values: [Float]
}

class BluetoothConnect: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{

    var centralManager: CBCentralManager!
    var peripheralBLE: CBPeripheral!

    //var arrayValues = valuesFromMeasurement()
    @Published var stopMeasure = 1
    @Published var connected = 0
    
    @Published var listOfValues = [Float]()

    let GATTService = CBUUID(string: "34802252-7185-4D5D-B431-630E7050E8F0")
    let GATTCommand = CBUUID(string: "34802252-7185-4D5D-B431-630E7050E8F0")
    let GATTData = CBUUID(string: "34802252-7185-4D5D-B431-630E7050E8F0")

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("Central state is unknown")
          case .resetting:
            print("Central state is resetting")
          case .unsupported:
            print("Central state is unsupported")
          case .unauthorized:
            print("Central state is unauthorized")
          case .poweredOff:
            print("Central state is poweredOff")
          case .poweredOn:
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        @unknown default:
            print("Unknown")
        }
    }

    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi: NSNumber) {
        print("Did Discover")
        if let pname = peripheral.name{
            print(pname)
            if pname == "Arduino"{
                self.centralManager.stopScan()
                self.peripheralBLE = peripheral
                self.peripheralBLE.delegate = self
                self.centralManager.connect(peripheral, options: nil)
            }
        }
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

        print("Did Connect")
        self.connected = 1
        peripheral.discoverServices(nil)
        central.scanForPeripherals(withServices: [GATTService], options: nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error? ){
        for service in peripheral.services!{
            print("Service Found")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

        print("Did discover Characteristics")
        guard let characteristics = service.characteristics else {return}
      
        for characteristic in characteristics {
            if characteristic.uuid == GATTData {
                print("Data")
                peripheral.setNotifyValue(true, for: characteristic)
            }
            if characteristic.uuid == GATTCommand {
                print("Command")
                
                //let parameter: [UInt8] = [1, 99, 47, 101, 97, 115, 47, 73, 77, 85, 54, 47, 53, 50]
                
                //let data = NSData(bytes: parameter, length: parameter.count)
                //peripheral.writeValue(data as Data, for: characteristic, type: CBCharacteristicWriteType.withResponse)
                
            }
            
        }

    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
    error: Error?){

        switch characteristic.uuid {
        case GATTData:
            let characteristicValue = characteristic.value
            
            var byteArray: [UInt8] = []
            for i in characteristicValue!{
                let n: UInt8 = i
                byteArray.append(n)
            }
            
            let value = bytesToFloat(bytes:  [byteArray[3], byteArray[2], byteArray[1], byteArray[0]])
            
            if stopMeasure == 0{
                let NewtonValue = 9.82*(value - 8151)/(44.2)
                addvalue(value: NewtonValue)
                print(value)
            }

        default:
            print("Unhandled Characteristic")
        }
    }
    
    func bytesToFloat(bytes b: [UInt8]) -> Float {

        let bigEndianValue = b.withUnsafeBufferPointer{
            $0.baseAddress!.withMemoryRebound(to: UInt32.self, capacity: 1){$0.pointee}
        }
        let bitPattern = UInt32(bigEndian: bigEndianValue)

        return Float(bitPattern: bitPattern)
        
    }

    override func viewDidLoad(){

        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)

    }

    func startScan(){
        centralManager = CBCentralManager(delegate: self, queue: nil)

    }

    func stop(){
        self.stopMeasure = 1
        
        if(peripheralBLE != nil){
            centralManager.cancelPeripheralConnection(peripheralBLE)
            
        }
    }
    
    func addvalue(value: Float){
        listOfValues.append(value)
    }
    func getValues()-> [Float]{
        return listOfValues
    }
    func changeVariable(newValue: Int){
        self.stopMeasure = newValue
    }
    func resetList(){
        self.listOfValues = []
    }
}


//class valuesFromMeasurement: ObservableObject {
//}

