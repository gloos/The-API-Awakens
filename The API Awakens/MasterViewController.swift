//
//  MasterViewController.swift
//  The API Awakens
//
//  Created by Gary Luce on 17/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var icons = [["Characters": #imageLiteral(resourceName: "icon-characters")], ["Vehicles": #imageLiteral(resourceName: "icon-vehicles")], ["Starships": #imageLiteral(resourceName: "icon-starships")]]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(icons.count)
        
    }

    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPerson" {
            SWAPIClient(type: .people, configuration: .default).fetch() { json in
                if let jason = json["results"] as? [[String:AnyObject]] {
                    var people: [Person] = []
                    for person in jason {
                        if let pers = Person(json: person) {
                            people.append(pers)
                        }
                    }
                    let destionationVC = segue.destination as! UINavigationController
                    let vc = destionationVC.topViewController as! CharacterViewController
                    vc.people = people
                }
                
            }
        } else if segue.identifier == "showStarship" {
            SWAPIClient(type: .starships, configuration: .default).fetch() { json in
                if let jason = json["results"] as? [[String:AnyObject]] {
                    var starships: [Spaceship] = []
                    for spaceship in jason {
                        if let ship = Spaceship(json: spaceship) {
                            starships.append(ship)
                            print(ship)
                        }
                    }
                    let destionationVC = segue.destination as! UINavigationController
                    let vc = destionationVC.topViewController as! SpaceshipViewController
                    vc.starships  = starships
                }
                
            }

        } else if segue.identifier == "showVehicle" {
            SWAPIClient(type: .vehicles, configuration: .default).fetch() { json in
                if let jason = json["results"] as? [[String:AnyObject]] {
                    var vehicles: [Vehicle] = []
                    for vehicle in jason {
                        if let ship = Vehicle(json: vehicle) {
                            vehicles.append(ship)
                            print(ship)
                        }
                    }
                    let destionationVC = segue.destination as! UINavigationController
                    let vc = destionationVC.topViewController as! VehicleViewController
                    vc.vehicles = vehicles
                }
                
            }
        }

    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableviewCell
        let data = icons[indexPath.row]
        for (key, value) in data {
            cell.labelView.text = key
            cell.artworkView.image = value
        }


        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "showPerson", sender: indexPath)
        case 1:
            self.performSegue(withIdentifier: "showVehicle", sender: indexPath)
        case 2:
            self.performSegue(withIdentifier: "showStarship", sender: indexPath)
        default:
            break
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


    

}


