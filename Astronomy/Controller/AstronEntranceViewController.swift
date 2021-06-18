//
//  AstronEntranceViewController.swift
//  Astronomy
//
//  Created by 方芸萱 on 2021/6/18.
//

import UIKit

class AstronEntranceViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = "Astronomy Picture of the Day"
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 18.0)

        requestButton.setTitle("Request", for: .normal)
        requestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
    }

}
