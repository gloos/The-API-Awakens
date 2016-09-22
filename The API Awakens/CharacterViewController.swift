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
            let bigsmall = smallestAndBiggest(people: people)
            print(bigsmall)
        }
    }

    var characterTraits = ["Born", "Home", "Height", "Eyes", "Hair"]
    var person: Person? {
        didSet {
            self.title = person?.name
            self.char = [["Born": person!.birthYear], ["Home": person!.homeworld], ["Height": person!.height], ["Eyes": person!.eyeColor], ["Hair": person!.hairColor]]
            self.tableView.reloadData()
        }
    }
    var char: [[String: String]] = [["Born": "1"], ["Home": "Earth"], ["Height": "194"], ["Eyes": "Blue"], ["Hair": "Dark"]]
    @IBOutlet weak var picker: UIPickerView!
@IBOutlet weak var charName: UILabel!

    @IBOutlet weak var tableView: UITableView!
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
        for (key, value) in dict {
            cell.traitLabel.text = key
            cell.traitValueLabel.text = value
        }
        print(dict)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterTraits.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: Helper methods
    
    func smallestAndBiggest(people: [Person]) -> (Person, Person) {
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
        return (smallest, biggest)
    }
}

