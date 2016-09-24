//
//  DetailViewController.swift
//  The API Awakens
//
//  Created by Gary Luce on 17/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var people: [Person] = [] {
        didSet {
            picker.reloadAllComponents()
            smallestAndBiggest(people: people)
            self.person = people.first
        }
    }
    
    // The tableview will be populatd with these default values.
    var characterTraits = ["Born", "Home", "Height", "Eyes", "Hair"]
    var person: Person? {
        didSet {
            self.loadPlanetObject()
            self.title = person?.name
            self.char = [["Born": person!.birthYear], ["Home": person!.homeworld], ["Height": person!.height], ["Eyes": person!.eyeColor], ["Hair": person!.hairColor]]
            self.tableView.reloadData()
        }
    }
    // Once a Planet object is created, this value will be set.
    var planet: Planet? {
        didSet {
            if let name = planet?.name {
                self.person?.homeworld = name
            }
        }
    }
    var char: [[String: String]] = [["Born": "1"], ["Home": "Earth"], ["Height": "194"], ["Eyes": "Blue"], ["Hair": "Dark"]]
    @IBOutlet weak var picker: UIPickerView!


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
        return people.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.person = people[row]
    }
    
    //MARK: Table View
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharactersTableViewCell
        let dict = self.char[indexPath.row]
        cell.bornLabel.textColor = UIColor(red: 121/255.0, green: 206/255.0, blue: 255/255.0, alpha: 1.0)
        cell.bornLabel.widthAnchor.constraint(equalToConstant: 100)
        cell.bornLabelValue.textColor = UIColor.white
        cell.cellButtonsStackView.addArrangedSubview(cell.bornLabel)
        cell.cellButtonsStackView.addArrangedSubview(cell.bornLabelValue)
        for (key, value) in dict {
            cell.bornLabel.text = key
            cell.bornLabelValue.text = value
            if key == "Height" {                
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
    
    //This determines the smallest and biggest objects and populates data at the bottom of the view controller.
    func smallestAndBiggest(people: [Person]) {
        var smallest = people[0]
        var biggest = people[0]
        for person in people {
            if let heightInt1 = Int(person.height), let heightInt2 = Int(smallest.height), heightInt1 <= heightInt2 {
                smallest = person
            }
        }
        for person in people {
            if let heightInt1 = Int(person.height), let heightInt2 = Int(smallest.height), heightInt1 >= heightInt2 {
                biggest = person

            }
        }
        self.smallestLabelValue.text = smallest.name
        self.largestLabelValue.text = biggest.name
    }
    
    
    // This converts values.
    func englishButtonPressed(sender: UIButton) {
        let indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as! CharactersTableViewCell?, let textFloat = Float(cell.bornLabelValue.text!) {
            let inches = textFloat * 0.393700787401
            cell.bornLabelValue.text = String(inches)
            cell.englishButton.isEnabled = false
            cell.englishButton.alpha = 0.5
            cell.metricButton.isEnabled = true
            cell.metricButton.alpha = 1.0
        }
    }
    
    func metricButtonPressed(sender: UIButton) {
        let indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as! CharactersTableViewCell?, let textFloat = Float(cell.bornLabelValue.text!) {
            let cms = Int(textFloat * 2.54) + 1
            cell.bornLabelValue.text = String(cms)
            cell.englishButton.isEnabled = true
            cell.englishButton.alpha = 1.0
            cell.metricButton.alpha = 0.5
            cell.metricButton.isEnabled = false
        }
    }
    
    // This loads the Planet() object from the url returned by the API results.
    func loadPlanetObject() {
        SWAPIClient(type: .planet, configuration: .default).fetch(stringURL: (self.person?.homeworld)!) { json in
            self.planet = Planet(json: json)
        }
    }
}

