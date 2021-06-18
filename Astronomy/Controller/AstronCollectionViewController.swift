//
//  AstronCollectionViewController.swift
//  Astronomy
//
//  Created by 方芸萱 on 2021/6/18.
//

import UIKit

class AstronCollectionViewController: UICollectionViewController {
    
    var astronItems = [AstronItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initCollectionViewFlowLayout()
        
        self.collectionView.register(UINib(nibName: K.astronCellNibName, bundle: nil), forCellWithReuseIdentifier: K.astronCellIdentifier)
        
        AstronController.shared.fetchAstronData { (astronItems) in
            if let astronItems = astronItems{
                self.astronItems = astronItems
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func initCollectionViewFlowLayout(){
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout?.minimumLineSpacing = CGFloat(K.collectionLineSpacing)
        flowLayout?.minimumInteritemSpacing = CGFloat(K.collectionInteritemSpacing)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return astronItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.astronCellIdentifier, for: indexPath) as! AstronCell
    
        cell.update(astronItems[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.showAstronDetailSegue, sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.showAstronDetailSegue{
            let destinationVC = segue.destination as! AstronDetailViewController
            let index = collectionView.indexPathsForSelectedItems![0]
            let astronIndex = index[1]
            destinationVC.astronItem = astronItems[astronIndex]
        }
    }

}
