import Foundation
@testable import NewsApp

final class NewsViewSpy: NewsView {
    
    var displayNavigationTitle: String?
    var refreshNewsViewcalled = false
    var showLoadingIndicatorCalled = false
    var hideLoadingIndicatorCalled = false
    var displayNewsRetrievalErrorTitle: String?
    var displayNewsRetrievalErrorMessage: String?
    
    func refreshNewsView() {
        refreshNewsViewcalled = true
    }
    
    func showLoadingIndicator() {
        showLoadingIndicatorCalled = true
    }
    
    func hideLoadingIndicator() {
        hideLoadingIndicatorCalled = true
    }
    
    func displayNavigationBar(title: String) {
        displayNavigationTitle = title
    }
    
    func displayNewsRetrievalError(title: String, message: String) {
        displayNewsRetrievalErrorTitle = title
        displayNewsRetrievalErrorMessage = message
    }
    
}
