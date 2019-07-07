import XCTest
import GAInfiniteCollectionKit_iOS

class GAInfiniteScrollingBehaviorTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: GAInfiniteScrollingBehavior!
    
    //MARK: - Properties
    var collectionView              : UICollectionView!
    var dataSourceDelegateHandler   : DataSourceDelegateHandler!
    
    // MARK: - Test lifecycle
    override func setUp()
    {
        super.setUp()
        setupOperation()
    }
    
    override func tearDown()
    {
        tearDownOperation()
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupOperation()
    {
        let rect    = CGRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 80))
        let items   = ["number 1","number 2","number 3","number 4","number 5","number 6","number 7"]
        
        collectionView              = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        dataSourceDelegateHandler   = DataSourceDelegateHandler(items: items, collectionView: collectionView)
        sut                         = GAInfiniteScrollingBehavior(collectionView: collectionView, dataSource: dataSourceDelegateHandler, delegate: dataSourceDelegateHandler)
    }
    
    func tearDownOperation()
    {
        sut                         = nil
        dataSourceDelegateHandler   = nil
        collectionView              = nil

    }
    
    // MARK: - Tests
    func testNumberOfItems()
    {
        // Given
        let comperObject = dataSourceDelegateHandler.items.count * 3
        
        // When
        let sutNumberOfCell = sut.collectionView(collectionView, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertTrue(sutNumberOfCell == comperObject, "sutNumberOfCell soulde be equal to comperObject")
    }
    
    func testLastIndexInOriginalDataSet()
    {
        // Given
        let comperObject    = dataSourceDelegateHandler.items.count - 1
        let cellIndex       = sut.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        
        // When
        let indexInItems = sut.indexInOriginalDataSet(forIndexInBoundaryDataSet: cellIndex)
        
        // Then
        XCTAssertTrue(indexInItems == comperObject, "sutNumberOfCell soulde be equal to comperObject")
    }
    
    func testMiddelIndexInOriginalDataSet()
    {
        // Given
        let comperObject = dataSourceDelegateHandler.items.count / 2
        let cellIndex = sut.collectionView(collectionView, numberOfItemsInSection: 0) / 2
        
        // When
        let indexInItems = sut.indexInOriginalDataSet(forIndexInBoundaryDataSet: cellIndex)
        
        // Then
        XCTAssertTrue(indexInItems == comperObject, "sutNumberOfCell soulde be equal to comperObject")
    }
    
    func testLastIndexInOriginalDataSetNotInfiniteScrolling()
    {
        // Given
        let rect    = CGRect(origin: CGPoint.zero, size: CGSize(width: 1000, height: 80))
        let items   = ["number 1","number 2"]
        
        collectionView              = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        dataSourceDelegateHandler   = DataSourceDelegateHandler(items: items, collectionView: collectionView)
        sut                         = GAInfiniteScrollingBehavior(collectionView: collectionView, dataSource: dataSourceDelegateHandler, delegate: dataSourceDelegateHandler)
        
        let comperObject    = dataSourceDelegateHandler.items.count - 1
        let cellIndex       = sut.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        
        // When
        let indexInItems = sut.indexInOriginalDataSet(forIndexInBoundaryDataSet: cellIndex)
        
        // Then
        XCTAssertTrue(indexInItems == comperObject, "sutNumberOfCell soulde be equal to comperObject")
    }
    
    func testMiddelIndexInOriginalDataSetNotInfiniteScrolling()
    {
        // Given
        let rect    = CGRect(origin: CGPoint.zero, size: CGSize(width: 1000, height: 80))
        let items   = ["number 1","number 2"]
        
        collectionView              = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        dataSourceDelegateHandler   = DataSourceDelegateHandler(items: items, collectionView: collectionView)
        sut                         = GAInfiniteScrollingBehavior(collectionView: collectionView, dataSource: dataSourceDelegateHandler, delegate: dataSourceDelegateHandler)
        
        let comperObject = dataSourceDelegateHandler.items.count / 2
        let cellIndex = sut.collectionView(collectionView, numberOfItemsInSection: 0) / 2
        
        // When
        let indexInItems = sut.indexInOriginalDataSet(forIndexInBoundaryDataSet: cellIndex)
        
        // Then
        XCTAssertTrue(indexInItems == comperObject, "sutNumberOfCell soulde be equal to comperObject")
    }
}
