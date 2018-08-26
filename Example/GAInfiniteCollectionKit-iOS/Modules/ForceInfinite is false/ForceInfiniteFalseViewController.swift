//
//  ViewController.swift
//  InfiniteCollectionKit-iOS
//
//  Created by idoMeirov on 08/19/2018.
//  Copyright (c) 2018 idoMeirov. All rights reserved.
//

import UIKit
import GAInfiniteCollectionKit_iOS

class ForceInfiniteFalseViewController: UIViewController
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
        // Do any additional setup after loading the view, typically from a nib.
        
        array = ["number 1","number 2","number 3","number 4","number 5","number 6","number 7"]
        
        infiniteScrollingBehavior   = GAInfiniteScrollingBehavior(collectionView: collectionView, dataSource: self, delegate: self, forceInfinite: false)
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
extension ForceInfiniteFalseViewController : GAInfiniteScrollingBehaviorDataSource
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
extension ForceInfiniteFalseViewController : GAInfiniteScrollingBehaviorDelegate
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
