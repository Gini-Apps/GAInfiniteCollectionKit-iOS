<h1 align="center">
  <a href="https://www.gini-apps.com/"><img src="https://cdn.xplace.com/companyLogo/u/e/uedrxh.png" alt="Markdownify" width="200"></a>
  <br>
  GAInfiniteCollectionKit-iOS
  <br>
</h1>

<h4 align="center">Give your collection view the infinite scrolling behavior.</h4>

<p align="center">
  <img alt="Sponsor" src="https://img.shields.io/badge/sponsor-Gini--Apps-brightgreen.svg">
  <img alt="Version" src="https://img.shields.io/badge/pod-v1.0.0-blue.svg">
  <img alt="Author" src="https://img.shields.io/badge/author-Ido Meirov-yellow.svg">
  <img alt="Swift" src="https://img.shields.io/badge/swift-4.1%2B-orange.svg">
  <img alt="Swift" src="https://img.shields.io/badge/platform-ios-lightgrey.svg">
</p>

<p align="center">
  <a href="https://www.cocoacontrols.com/controls/gainfinitecollectionkit-ios-1188a0d0-b0df-4e50-9536-65f4019b0ec0"><img src = "https://github.com/shay-somech/GAInfiniteCollectionKit-iOS/blob/master/Documents/InfiniteCollectionKit.gif"></a>	  
</p>

<p align="center">
	<a href="https://www.cocoacontrols.com/controls/gainfinitecollectionkit-ios-1188a0d0-b0df-4e50-9536-65f4019b0ec0"><img src="./Documents/appetize.png" /></a>
</p>


#### Table of Contents  
1. [Requirements](#requirements)
2. [Installation](#installation)
3. [How to Use](#howToUse) 
4. [Advanced uses](#advancedUses) 

<a name="requirements"/>

# Requirements:
* iOS 9.0+ 
* Xcode 9.4+
* Swift 4.1+

<a name="installation"/>

# Installation:

### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:
```
$ gem install cocoapods
```
To integrate GAInfiniteCollectionKit-iOS into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
  pod 'GAInfiniteCollectionKit-iOS'
end
```
Then, run the following command:
```
$ pod install
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

