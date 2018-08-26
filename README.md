<h1 align="center">
  <a href="http://www.amitmerchant.com/electron-markdownify"><img src="https://cdn.xplace.com/companyLogo/u/e/uedrxh.png" alt="Markdownify" width="200"></a>
  <br>
  GAInfiniteCollectionKit-iOS
  <br>
</h1>

<h4 align="center">Give your collection view the infinite scrolling behavior.</h4>

<p align="center">
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-brightgreen.svg">
  <img alt="Author" src="https://img.shields.io/badge/author-Ido Meirov-blue.svg">
  <img alt="Swift" src="https://img.shields.io/badge/swift-4.1%2B-orange.svg">
</p>

<p align="center">
  <img src = "https://github.com/shay-somech/GAInfiniteCollectionKit-iOS/blob/master/Documents/InfiniteCollectionKit.gif">
</p>

#### Table of Contents  
1. [Installation](#installation)
2. [How to Use](#howToUse) 
3. [Advanced uses](#advancedUses) 

<a name="installation"/>

# Installation:

### CocoaPods:
```
pod GAInfiniteCollectionKit-iOS
```

<a name="howToUse"/>

# How to Use:

## Step one:
Create instance of InfiniteScrollingBehavior and set the collection view
delgate and dataSource to the InfiniteScrollingBehavior instance,
The infinite Scrolling will work only if the numner of item is bigger then the frame of the collection view

### Example: 
```swift
infiniteScrollingBehavior   = InfiniteScrollingBehavior(collectionView: collectionView, dataSource: self, delegate: self, forceInfinite: false)
collectionView.delegate     = infiniteScrollingBehavior
collectionView.dataSource   = infiniteScrollingBehavior
```
## Step two:
Implement the protocols InfiniteScrollingBehaviorDataSource and InfiniteScrollingBehaviorDelegate

### Example: 
```swift
// MARK: - InfiniteScrollingBehaviorDataSource
extension MyObject : InfiniteScrollingBehaviorDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, withIndexForItem itemIndex: Int) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        
        configor(cell: cell, in: itemIndex)
        return cell
    }
    
    func numberOfItems() -> Int
    {
        return array.count
    }
}

// MARK: - InfiniteScrollingBehaviorDelegate
extension MyObject : InfiniteScrollingBehaviorDelegate
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
```

<a name="advancedUses"/>

# Advance Uses:

## forceInfinite:
To force infinite Scrolling pass true in the constructor of the InfiniteScrollingBehavior.

### Example: 
```swift
infiniteScrollingBehavior   = InfiniteScrollingBehavior(collectionView: collectionView, dataSource: self, delegate: self, forceInfinite: true)
```

