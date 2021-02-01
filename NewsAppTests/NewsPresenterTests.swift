import XCTest
@testable import NewsApp

class NewsPresenterTests: XCTestCase {
    
    var presenter: NewsPresenter!
    var newsViewSpy: NewsViewSpy!
    
    override func setUp() {
        super.setUp()
        newsViewSpy = NewsViewSpy()
        presenter = NewsPresenter(view:newsViewSpy)
    }
    
    override func tearDown() {
        presenter = nil
        newsViewSpy = nil
        super.tearDown()
    }
    
    func test_ViewNavigationBar_displayTitle() {
        
        let expectedNavigationBarTitle = "News"
        
        presenter.loadView()
        
        XCTAssertEqual(expectedNavigationBarTitle,newsViewSpy.displayNavigationTitle, "NavigationTitle is Matched")
    }
}
