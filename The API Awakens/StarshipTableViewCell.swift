//
//  StarshipTableViewCell.swift
//  The API Awakens
//
//  Created by Gary Luce on 24/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//


import UIKit

class StarshipTableViewCell: UITableViewCell {
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var traitValueLabel: UILabel!
    
    @IBOutlet weak var cellButtonsStackView: UIStackView!
    
    let bornLabel = UILabel()
    
    let bornLabelValue = UILabel()
    let englishButton = UIButton(type: .roundedRect)
    let metricButton = UIButton(type: .roundedRect)
    let usdButton = UIButton(type: .roundedRect)
    let galacticButton = UIButton(type: .roundedRect)
}
