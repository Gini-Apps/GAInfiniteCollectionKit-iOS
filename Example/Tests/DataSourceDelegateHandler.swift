//
//  DataSourceDelegateHandler.swift
//  GAInfiniteCollectionKit-iOS_Example
//
//  Created by Ido Meirov on 07/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import GAInfiniteCollectionKit_iOS

class DataSourceDelegateHandler: NSObject
{
    // MARK: - Properties
    let items: [Any]
    let cellID = "TestCellID"

    // MARK: - ObjectLifeCycle
    init(items: [Any], collectionView: UICollectionView)
    {
        self.items = items
        super.init()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
}

extension DataSourceDelegateHandler: GAInfiniteScrollingBehaviorDataSource
{
    func numberOfItems() -> Int
    {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, withIndexForItem itemIndex: Int) -> UICollectionViewCell
    {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    }
}

extension DataSourceDelegateHandler: GAInfiniteScrollingBehaviorDelegate
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10.0
    }
}
