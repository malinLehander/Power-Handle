//
//  MeasurementViewModel.swift
//  project2021
//
//  Created by Malin Lehander on 2021-12-20.
//

import Foundation
import SwiftUI

class MeasurementViewModel: ObservableObject {
    
    @Published var measurements = [measurementObject]()
    //@Published var values = [Double]()
    
    var BLEConnect = BluetoothConnect()
    //var listValues = valuesFromMeasurement()
    
    
    func addObject(name: String, values: [Float])-> Bool{
        let object = measurementObject(date: name, values: values)
        measurements.append(object)
        
        self.measurements = measurements
        
        return true
        
    }
    func measurementDone(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        let name = formatter.string(from: date)
        let values = BLEConnect.getValues()
        addObject(name: name, values: values)
        
    }
    func getIndexOfObject(object: measurementObject) -> Int {
        guard let index = measurements.firstIndex(of: object) else { return 0 }
        return index
    }
    func getObjectAtIndex(index: Int) -> String{
        
        if measurements.count == 0{
            return ""
        }
        
        let object: measurementObject = measurements[index]
        let name = object.date
        return name
    }
    func getValuesOfObject(index: Int)-> [Float]{
        if measurements.count == 0{
            return [Float(0)]
        }
        let object: measurementObject = measurements[index]
        let values = object.values
        return values
    }
    
    func removeObject(index: Int){
        measurements.remove(at: index)
        self.measurements = measurements
    }
    
    @IBAction func StartBLTButtonPressed(_ sender: Any) {
        BLEConnect.startScan()
        
    }
    @IBAction func StartButtonPressed(_ sender: Any) {
        BLEConnect.resetList()
        BLEConnect.changeVariable(newValue: 0)
        
    }
    @IBAction func StopButtonPressed(_ sender: Any) {
        BLEConnect.stop()
        
    }
    func getValuesFromMeasurement() -> [Float]{
        let listOfMeasures = BLEConnect.getValues()
        return listOfMeasures
    }
    
    func getFloatAsDouble(value: [Float]) -> [Double] {
        
        var doubleArray = [Double]()
        
        for i in (0..<value.count){
            let stringValue = String(value[i])
            guard let doubleValue = Double(stringValue) else { return [0.0] }
            doubleArray.append(doubleValue)
        }
        return doubleArray
    }
    func calculateAverage(list: [Float]) -> Int{
        var total = Float()
        var number: Float = 0
        
        for i in (0..<list.count){
            if list[i]>1 {
                total = total + list[i]
                number = number+1
            }
            
        }
        return Int(total / number)
        
    }
    func isConnected()-> Bool{
        let connected = BLEConnect.connected
        if connected == 1{
            return true
        }
        else {
            return false
        }
    }
    
}
