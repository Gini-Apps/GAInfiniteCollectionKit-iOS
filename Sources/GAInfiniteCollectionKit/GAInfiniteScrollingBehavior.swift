//
//  GAInfiniteScrollingBehavior.swift
//  UICollectionViewInfiniteScrolling
//
//  Created by Ido Meirov on 23/04/2017.
//  Copyright © 2017 Ido Meirov. All rights reserved.
//

import UIKit
///111111
@objc(GAInfiniteScrollingBehaviorDataSource)
public protocol GAInfiniteScrollingBehaviorDataSource: class
{
    
    /// The number of item / cell to create
    ///
    /// - Returns: retirn the number of item
    func numberOfItems() -> Int
    
    /// Replace "collectionView: cellForItemAtIndexPath:" add the index of the item and the cell index.
    /// cell index is not the same as item index becuse the infinite scrolling
    ///
    /// - Parameters:
    ///   - collectionView: the collection view of the cell
    ///   - indexPath: cell index path
    ///   - itemIndex: the orginal index of the item / object
    /// - Returns: must return cell by the call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, withIndexForItem itemIndex : Int) -> UICollectionViewCell
}

@objc(GAInfiniteScrollingBehaviorDelegate)
public protocol GAInfiniteScrollingBehaviorDelegate: UIScrollViewDelegate
{
    
    /// call for every cell to get its size
    ///
    /// - Parameters:
    ///   - collectionView: the collection view of the cell
    ///   - collectionViewLayout: the layout of the collection view
    ///   - indexPath: cell index path
    /// - Returns: cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    
    /// Minimum line spacing for section
    ///
    /// - Parameters:
    ///   - collectionView: the collection view of the section
    ///   - collectionViewLayout: the layout of the collection view
    ///   - section: the section number
    /// - Returns: line spacing for sction
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    
    /// Minimum interitem spacing for section
    ///
    /// - Parameters:
    ///   - collectionView: the collection view of the section
    ///   - collectionViewLayout: the layout of the collection view
    ///   - section: the section number
    /// - Returns: interitem spacing for sction
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    
    /// Call for every call selection
    ///
    /// - Parameters:
    ///   - collectionView: the colleation view of the selection index path
    ///   - indexPath: the orginal index of the item
    @objc optional func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    
    /// Will display cell
    ///
    /// - Parameters:
    ///   - collectionView: the colleation view of the cell
    ///   - cell: the celll that will display
    ///   - indexPath: the orginal index of the item
    @objc optional func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
}

public class GAInfiniteScrollingBehavior: NSObject
{
    // MARK: - Properties
    public weak var dataSource  : GAInfiniteScrollingBehaviorDataSource?
    public weak var delegate    : GAInfiniteScrollingBehaviorDelegate?
    
    private var forceInfinite        : Bool
    
    private var isInfiniteScrolling  : Bool
    private var dataSourceMultiplier : Int
    private var centerDataSource     : Int
    
    private var originalNumberOfItems : Int
    {
        return dataSource?.numberOfItems() ?? 0
    }
    
    private var numberOfItems : Int
    {
        
        guard isInfiniteScrolling else { return originalNumberOfItems }
        return originalNumberOfItems * dataSourceMultiplier
    }
    
    // MARK: - Init
    
    /// create instance of InfiniteScrollingBehavior
    ///
    /// - Parameters:
    ///   - collectionView: the collection to add infinite scrolling
    ///   - dataSource: the object that implement GAInfiniteScrollingBehaviorDataSource
    ///   - delegate: the object that implement GAInfiniteScrollingBehaviorDelegate
    ///   - forceInfinite: bool to force infinite scrolling when that object are not enough for scrolling the collection view
    public required init(collectionView: UICollectionView, dataSource: GAInfiniteScrollingBehaviorDataSource, delegate : GAInfiniteScrollingBehaviorDelegate, forceInfinite : Bool = false)
    {
        self.isInfiniteScrolling  = false
        self.dataSource           = dataSource
        self.delegate             = delegate
        self.forceInfinite        = forceInfinite
        self.dataSourceMultiplier = 3
        self.centerDataSource     = 2
        super.init()
        
        self.updateInfiniteScrollingIfNeeded(collectionView: collectionView)
    }
    
    deinit
    {
        print("InfiniteScrollingBehavior deinitialized")
    }
    
    //MARK: - Methods
    private func passMinimum(for collectionView: UICollectionView) -> Bool
    {
        guard let delegate = delegate else { return false}
        let collectionViewWidth = collectionView.frame.width
        let spacing = delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumLineSpacingForSectionAt: 0)
        let cellWidth = delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0)).width + spacing
        
        guard  originalNumberOfItems == 2 && collectionViewWidth == cellWidth else { return false }
        
        return true
    }
    
    private func shouldEnableInfiniteScroll(collectionView: UICollectionView) -> Bool
    {
        guard let delegate = delegate else { isInfiniteScrolling = false ; return isInfiniteScrolling}
        var contentSizeWidth = CGFloat(0.0)
        let collectionViewWidth = collectionView.frame.width
        
        for index in 0..<originalNumberOfItems
        {
            let spacing = delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumLineSpacingForSectionAt: index)
            contentSizeWidth += delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: index, section: 0)).width + spacing
        }
        
        isInfiniteScrolling = contentSizeWidth > collectionViewWidth
        let passTheMinimum = passMinimum(for: collectionView)
        
        guard (!isInfiniteScrolling && forceInfinite) else
        {
            if (isInfiniteScrolling && passTheMinimum)
            {
                centerDataSource += 1
                dataSourceMultiplier += 2
            }
            
            return isInfiniteScrolling
        }
        
        var multiplier : CGFloat = 1
        
        while contentSizeWidth <= collectionViewWidth
        {
            multiplier += 1
            centerDataSource += 1
            dataSourceMultiplier += 2
            contentSizeWidth *= multiplier
        }
        
        isInfiniteScrolling = true
        
        return isInfiniteScrolling
    }
    
    private func updateInfiniteScrollingIfNeeded(collectionView: UICollectionView)
    {
        
        guard shouldEnableInfiniteScroll(collectionView: collectionView) else { return }
    }
    
    private func indexPathForScrollTopColletionView(by index : Int) -> IndexPath
    {
        var returnValue = index
        
        if isInfiniteScrolling
        {
            returnValue += (numberOfItems / dataSourceMultiplier)
        }
        
        return IndexPath(item: returnValue, section: 0)
    }
    
    private var moving = false
    
    private func updateCollectionViewOffset(collectionView: UICollectionView)
    {
        guard let delegate = delegate else { return }
        guard isInfiniteScrolling else { return }
        guard numberOfItems > 0 else { return }
        
        updateSelectedCellIfNeeded(collectionView: collectionView)
        
        let spacing = delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumLineSpacingForSectionAt: 0)
        
        let firstCellWidth = delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0)).width + spacing
        let  lastCellWidth = delegate.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: numberOfItems - 1, section: 0)).width + spacing
        
        let contentOffset = collectionView.contentOffset
        let contentSize   = collectionView.contentSize
        
        if contentOffset.x <= firstCellWidth
        {
            var point = CGPoint(x:contentOffset.x + contentSize.width / CGFloat(dataSourceMultiplier) , y: contentOffset.y)
            
            if point.x >= ((contentSize.width / CGFloat(dataSourceMultiplier)) * CGFloat(centerDataSource)) - lastCellWidth
            {
                point.x = ((contentSize.width / CGFloat(dataSourceMultiplier)) * CGFloat(centerDataSource)) - lastCellWidth - 1.0
            }
            
            collectionView.contentOffset = point
        }
        else if contentOffset.x >= ((contentSize.width / CGFloat(dataSourceMultiplier)) * CGFloat(centerDataSource)) - lastCellWidth
        {
            var point = CGPoint(x:contentOffset.x - contentSize.width / CGFloat(dataSourceMultiplier) , y: contentOffset.y)
            
            if point.x <= firstCellWidth
            {
                point.x = firstCellWidth + 1.0
            }
            
            collectionView.contentOffset = point
        }
    }
    
    private func updateSelectedCellIfNeeded(collectionView: UICollectionView)
    {
        guard isInfiniteScrolling else { return }
        
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        guard let selectedIndex = selectedItems.first else { return }
        
        let selectedIndexInOriginalDataSet = indexInOriginalDataSet(forIndexInBoundaryDataSet: selectedIndex.item)
        
        for item in collectionView.visibleCells
        {
            guard let itemIndexPath = collectionView.indexPath(for: item) else { continue }
            
            let itemIndexInOriginalDataSet = indexInOriginalDataSet(forIndexInBoundaryDataSet: itemIndexPath.item)
            
            guard itemIndexInOriginalDataSet == selectedIndexInOriginalDataSet else { continue }
            collectionView.selectItem(at: itemIndexPath, animated: false, scrollPosition: .right)
            break;
        }
    }
}

//MARK: - UICollectionViewDataSource
extension GAInfiniteScrollingBehavior : UICollectionViewDataSource
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfItems
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let dataSource = dataSource
        {
            return dataSource.collectionView(collectionView, cellForItemAt: indexPath, withIndexForItem: indexInOriginalDataSet(forIndexInBoundaryDataSet: indexPath.item))
        }
        else
        {
            return UICollectionViewCell()
        }
    }
}

//MARK: - UIScrollViewDelegate Implementation
extension GAInfiniteScrollingBehavior : UIScrollViewDelegate
{
    public func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        delegate?.scrollViewDidScroll?(scrollView)
        guard let collectionView = scrollView as? UICollectionView else { return }
        updateCollectionViewOffset(collectionView: collectionView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        delegate?.scrollViewWillBeginDragging?(scrollView)
    }
}

//MARK: - UICollectionViewDelegate
extension GAInfiniteScrollingBehavior : UICollectionViewDelegate
{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let originalIndex = indexInOriginalDataSet(forIndexInBoundaryDataSet: indexPath.item)
        let originalIndexPath = IndexPath(item: originalIndex, section: indexPath.section)
        delegate?.collectionView?(collectionView, didSelectItemAt: originalIndexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GAInfiniteScrollingBehavior : UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        guard let delegate = delegate else { return CGSize.zero }
        return delegate.collectionView(collectionView,
                                       layout: collectionViewLayout,
                                       sizeForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        guard let delegate = delegate else { return 10 }
        return delegate.collectionView(collectionView,
                                       layout: collectionViewLayout,
                                       minimumLineSpacingForSectionAt: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        guard let delegate = delegate else { return 10 }
        return delegate.collectionView(collectionView,
                                       layout: collectionViewLayout,
                                       minimumInteritemSpacingForSectionAt: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        let itemIndex = indexInOriginalDataSet(forIndexInBoundaryDataSet: indexPath.item)
        delegate?.collectionView?(collectionView, willDisplay: cell, forItemAt: IndexPath(item: itemIndex, section: indexPath.section))
    }
}

//  MARK: - Public Methods
extension GAInfiniteScrollingBehavior
{
    
    /// return the original index of given cell index
    ///
    /// - Parameter index: the cell index
    /// - Returns: the original index of the item / object
    public func indexInOriginalDataSet(forIndexInBoundaryDataSet index: Int) -> Int
    {
        guard isInfiniteScrolling else { return index }
        return index % (numberOfItems / dataSourceMultiplier)
    }
}
