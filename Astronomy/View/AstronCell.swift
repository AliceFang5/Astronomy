//
//  AstronCell.swift
//  Astronomy
//
//  Created by 方芸萱 on 2021/6/18.
//

import UIKit

class AstronCell: UICollectionViewCell {
    @IBOutlet weak var astronImageView: UIImageView!
    @IBOutlet weak var astronTitleLabel: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    static let rowNumber = CGFloat(K.collectionRowNunber)
    static let interitemSpacing = CGFloat(K.collectionInteritemSpacing)
    static let width = floor((UIScreen.main.bounds.width - interitemSpacing * (rowNumber - 1)) / rowNumber)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthConstraint.constant = Self.width
    }
    
    func update(_ astronItem:AstronItem){
        astronTitleLabel.text = astronItem.title
        astronTitleLabel.textColor = .white
        astronTitleLabel.textAlignment = .center
        astronImageView.image = UIImage(systemName: "photo")
        astronImageView.contentMode = .scaleAspectFit
        AstronController.shared.fetchImage(withURL: astronItem.url) { (image) in
            if let image = image{
                DispatchQueue.main.async {
                    self.astronImageView.image = image
                    self.astronImageView.contentMode = .scaleAspectFill
                }
            }
        }
    }
}
