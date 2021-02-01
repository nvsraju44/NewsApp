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
}
