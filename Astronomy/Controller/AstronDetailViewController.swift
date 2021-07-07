//
//  AstronDetailViewController.swift
//  Astronomy
//
//  Created by 方芸萱 on 2021/6/18.
//

import UIKit

class AstronDetailViewController: UIViewController {
    @IBOutlet weak var astronImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var astronItem:AstronItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAstron()
    }
    
    func updateAstron(){
        let dateString = astronItem.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString){
            formatter.dateFormat = "yyyy MMM. d"
            dateLabel.text = formatter.string(from: date)
        }

        titleLabel.text = astronItem.title
        copyrightLabel.text = astronItem.copyright
        descriptionLabel.text = astronItem.description
        astronImageView.image = UIImage(systemName: "photo")
        astronImageView.contentMode = .scaleAspectFit
        AstronController.shared.fetchImage(withURL: astronItem.hdurl) { (result) in
            switch result{
            case .success(let image):
                DispatchQueue.main.async {
                    self.astronImageView.image = image
                    self.astronImageView.contentMode = .scaleAspectFill
                }
            case .failure(let networkError):
                switch networkError {
                case .invalidUrl, .invalidData, .invalidResponse:
                    print(networkError)
                case .requestFailed(let error), .decodingError(let error):
                    print(networkError, error)
                }
            }
        }
    }

}
