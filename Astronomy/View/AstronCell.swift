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
    
    func update(_ astronItem:AstronItem, collectionView: UICollectionView, indexPath: IndexPath, cell: UICollectionViewCell){
        astronTitleLabel.text = astronItem.title
        astronTitleLabel.textColor = .white
        astronTitleLabel.textAlignment = .center
        astronImageView.image = UIImage(systemName: "photo")
        astronImageView.contentMode = .scaleAspectFit
        AstronController.shared.fetchImage(withURL: astronItem.url) { (result) in
            switch result{
            case .success(let image):
                DispatchQueue.main.async {
                    if let currentIndexPath = collectionView.indexPath(for: cell), currentIndexPath != indexPath{
                        return
                    }
                    self.astronImageView.image = image
                    self.astronImageView.contentMode = .scaleAspectFill
                }
            case .failure( let networkError):
                switch networkError {
                case .invalidUrl, .invalidData, .invalidResponse:
                    print(networkError)
                case  .requestFailed(let error), .decodingError(let error):
                print(networkError, error)
                }
            }
        }
    }
}
