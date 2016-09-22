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
    var type: SWAPI = .people

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(icons.count)
        
    }

    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPerson" {
            SWAPIClient(type: self.type, configuration: .default).fetch() { json in
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


    

}


