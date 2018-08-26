//
//  ForceInfiniteTrueViewController.swift
//  InfiniteCollectionKit-iOS_Example
//
//  Created by ido meirov on 19/08/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GAInfiniteCollectionKit_iOS

class ForceInfiniteTrueViewController: UIViewController
{

    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    var array                       : [String]!
    var infiniteScrollingBehavior   : GAInfiniteScrollingBehavior!

    
    // MARK: - View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        array = ["number 1","number 2"]
        
        infiniteScrollingBehavior   = GAInfiniteScrollingBehavior(collectionView: collectionView, dataSource: self, delegate: self, forceInfinite: true)
        collectionView.delegate     = infiniteScrollingBehavior
        collectionView.dataSource   = infiniteScrollingBehavior
        
        collectionView.reloadData()
    }

    // MARK: - Method
    func configor(cell : UICollectionViewCell, in index: Int)
    {
        guard let mycell = cell as? CollectionViewCell else { return }
        
        mycell.cellLabel.text = array[index]
        
    }
}

// MARK: - InfiniteScrollingBehaviorDataSource
extension ForceInfiniteTrueViewController : GAInfiniteScrollingBehaviorDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, withIndexForItem itemIndex: Int) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellID, for: indexPath)
        
        configor(cell: cell, in: itemIndex)
        return cell
    }
    
    func numberOfItems() -> Int
    {
        return array.count
    }
}

// MARK: - InfiniteScrollingBehaviorDelegate
extension ForceInfiniteTrueViewController : GAInfiniteScrollingBehaviorDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 150, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
}
