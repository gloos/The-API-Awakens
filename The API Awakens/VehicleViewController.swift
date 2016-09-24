//
//  VehicleViewController.swift
//  The API Awakens
//
//  Created by Gary Luce on 24/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var vehicles: [Vehicle] = [] {
        didSet {
            
            picker.reloadAllComponents()
            smallestAndBiggest(vehicles: vehicles)
            self.vehicle = vehicles.first
            
        }
    }
    
    var characterTraits = ["Born", "Home", "Height", "Eyes", "Hair"]
    var vehicle: Vehicle? {
        didSet {
            // self.loadPlanetObject()
            self.title = vehicle?.name
            self.ship = [["Make": vehicle!.manufacturer], ["Cost": vehicle!.costInCredits], ["Length": vehicle!.length], ["Class": vehicle!.vehicleClass], ["Crew": vehicle!.crew]]
            self.tableView.reloadData()
        }
    }
    
    
    var ship: [[String: String]] = [["Make": ""], ["Cost": ""], ["Length": ""], ["Class": ""], ["Crew": ""]]
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var charName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var smallestLabelValue: UILabel!
    @IBOutlet weak var largestLabelValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    //MARK: Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vehicles[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.vehicle = vehicles[row]
    }
    
    //MARK: Table View
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VehicleTableViewCell
        let dict = self.ship[indexPath.row]
        cell.bornLabel.textColor = UIColor(red: 121/255.0, green: 206/255.0, blue: 255/255.0, alpha: 1.0)
        cell.bornLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        cell.bornLabelValue.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        cell.bornLabelValue.textColor = UIColor.white
        cell.cellButtonsStackView.addArrangedSubview(cell.bornLabel)
        cell.cellButtonsStackView.addArrangedSubview(cell.bornLabelValue)
        for (key, value) in dict {
            cell.bornLabel.text = key
            cell.bornLabelValue.text = value
            if key == "Length" {
                cell.englishButton.setTitle("English", for: .normal)
                cell.englishButton.tag = indexPath.row
                cell.englishButton.isEnabled = true
                cell.englishButton.alpha = 1.0
                cell.englishButton.addTarget(self, action: #selector(englishButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
                cell.englishButton.setTitleColor(.white, for: .normal)
                cell.metricButton.setTitle("Metric", for: .normal)
                cell.metricButton.tag = indexPath.row
                cell.metricButton.addTarget(self, action: #selector(metricButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
                cell.metricButton.isEnabled = false
                cell.metricButton.alpha = 0.5
                cell.metricButton.setTitleColor(.white, for: .normal)
                cell.cellButtonsStackView.addArrangedSubview(cell.englishButton)
                cell.cellButtonsStackView.addArrangedSubview(cell.metricButton)
            } else if key == "Cost" {
                cell.usdButton.setTitle("USD", for: .normal)
                cell.usdButton.tag = indexPath.row
                cell.usdButton.isEnabled = true
                cell.usdButton.alpha = 1.0
                cell.usdButton.addTarget(self, action: #selector(usdButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
                cell.usdButton.setTitleColor(.white, for: .normal)
                cell.galacticButton.setTitle("Galactic", for: .normal)
                cell.galacticButton.tag = indexPath.row
                cell.galacticButton.addTarget(self, action: #selector(galacticButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
                cell.galacticButton.isEnabled = false
                cell.galacticButton.alpha = 0.5
                cell.galacticButton.setTitleColor(.white, for: .normal)
                cell.cellButtonsStackView.addArrangedSubview(cell.usdButton)
                cell.cellButtonsStackView.addArrangedSubview(cell.galacticButton)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterTraits.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: Helper methods
    
    func smallestAndBiggest(vehicles: [Vehicle]) {
        var smallest = vehicles[0]
        var biggest = vehicles[0]
        for vehicle in vehicles {
            if let lengthDouble1 = Double(vehicle.length), let lengthDouble2 = Double(smallest.length), lengthDouble1 <= lengthDouble2 {
                smallest = vehicle
            }
        }
        for vehicle in vehicles {
            if let lengthDouble1 = Double(vehicle.length), let lengthDouble2 = Double(biggest.length), lengthDouble1 >= lengthDouble2 {
                biggest = vehicle
                
            }
        }
        self.smallestLabelValue.text = smallest.name
        self.largestLabelValue.text = biggest.name
    }
    
    func englishButtonPressed(sender: UIButton) {
        let indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as! VehicleTableViewCell?, let textFloat = Float(cell.bornLabelValue.text!) {
            let feet = textFloat * 3.28084
            cell.bornLabelValue.text = String(feet)
            cell.englishButton.isEnabled = false
            cell.englishButton.alpha = 0.5
            cell.metricButton.isEnabled = true
            cell.metricButton.alpha = 1.0
        }
    }
    
    func metricButtonPressed(sender: UIButton) {
        let indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as! VehicleTableViewCell?, let textFloat = Float(cell.bornLabelValue.text!) {
            let metres = Int(textFloat * 0.3048)
            cell.bornLabelValue.text = String(metres)
            cell.englishButton.isEnabled = true
            cell.englishButton.alpha = 1.0
            cell.metricButton.alpha = 0.5
            cell.metricButton.isEnabled = false
        }
    }
    
    func usdButtonPressed(sender: UIButton) {
        let indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as! VehicleTableViewCell?, let textDouble = Double(cell.bornLabelValue.text!) {
            let alert = UIAlertController(title: "Alert", message: "Enter your exchange rate", preferredStyle: UIAlertControllerStyle.alert)
            alert.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Conversion rate:"
            })
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { text in
                print(alert.textFields?[0].text)
                if let text = alert.textFields?[0].text, let doubleTextValue = Double(text), doubleTextValue > 0 {
                    let newValue = textDouble * doubleTextValue
                    cell.bornLabelValue.text = String(newValue)
                    cell.usdButton.isEnabled = false
                    cell.usdButton.alpha = 0.5
                    cell.galacticButton.isEnabled = true
                    cell.galacticButton.alpha = 1.0
                    
                } else {
                    self.presentTextFieldError()
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func galacticButtonPressed(sender: UIButton) {
        let indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as! VehicleTableViewCell?, let textDouble = Double(cell.bornLabelValue.text!) {
            let alert = UIAlertController(title: "Alert", message: "Enter your exchange rate", preferredStyle: UIAlertControllerStyle.alert)
            alert.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Conversion rate:"
            })
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { text in
                print(alert.textFields?[0].text)
                if let text = alert.textFields?[0].text, let doubleTextValue = Double(text), doubleTextValue > 0 {
                    let newValue = textDouble * doubleTextValue
                    cell.bornLabelValue.text = String(newValue)
                    cell.usdButton.isEnabled = true
                    cell.usdButton.alpha = 1.0
                    cell.galacticButton.alpha = 0.5
                    cell.galacticButton.isEnabled = false
                    
                } else {
                    self.presentTextFieldError()
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentTextFieldError() {
        let alert = UIAlertController(title: "Alert", message: "Fill the form correctly. Only positive numbers are accepted.", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}


