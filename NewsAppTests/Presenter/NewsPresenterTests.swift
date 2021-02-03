import XCTest
@testable import NewsApp

final class NewsPresenterTests: XCTestCase {
    
    var presenter: NewsPresenter!
    var newsViewSpy =  NewsViewSpy()
    var displayNewsStub = DisplayNewsStub()
    
    override func setUp() {
        super.setUp()
        presenter = NewsPresenter(view:newsViewSpy, delegate: displayNewsStub)
    }
    
    func test_loadView_success_refreshNewsView_called() {
        
        let newsToBeReturned = NewsList.createNewsArray()
        displayNewsStub.resultToBeReturned = .success(newsToBeReturned)
        
        presenter.loadView()
        
        XCTAssertTrue(newsViewSpy.refreshNewsViewcalled, "refreshNewsView is called")
    }
    
    func test_hideLoadingIndicatorCalled_when_success() {
        
        let newsToBeReturned = NewsList.createNewsArray()
        displayNewsStub.resultToBeReturned = .success(newsToBeReturned)
        
        presenter.loadView()
        
        XCTAssertTrue(newsViewSpy.hideLoadingIndicatorCalled, "loadingindicator called")
    }
    
    func test_hideLoadingIndicatorCalled_when_failed() {
        
        let newsToBeReturned = NewsList.createNewsArray()
        displayNewsStub.resultToBeReturned = .success(newsToBeReturned)
        
        presenter.loadView()
        
        XCTAssertTrue(newsViewSpy.hideLoadingIndicatorCalled, "loadingindicator called")
    }
    
    func test_loadView_success_numberofArticles() {
        
        let expectedNumberOfArticles = 20
        let newsToBeReturned = NewsList.createNewsArray(numberOfElements:expectedNumberOfArticles)
        displayNewsStub.resultToBeReturned = .success(newsToBeReturned)
        
        presenter.loadView()
        
        XCTAssertEqual(expectedNumberOfArticles, presenter.numberOfAricles, "number matched")
    }
    
    func test_loadView_failure_displayNewsRetrievalError_Title() {
        
        let expectedErrorTitle = "Error"
        let errorToBeReturned = NSError(domain: "", code: 0, userInfo: nil)
        displayNewsStub.resultToBeReturned = .failure(errorToBeReturned)
        
        presenter.loadView()
        
        XCTAssertEqual(expectedErrorTitle, newsViewSpy.displayNewsRetrievalErrorTitle, "Error title matched")
    }
    
    func test_loadView_failure_displayNewsRetrievalError_Message() {
        
        let expectedErrorMessage = "Error Message"
        let errorToBeReturned = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedErrorMessage])
        displayNewsStub.resultToBeReturned = .failure(errorToBeReturned)
        
        presenter.loadView()
        
        XCTAssertEqual(expectedErrorMessage, newsViewSpy.displayNewsRetrievalErrorMessage, "Error message title matched")
    }
}
