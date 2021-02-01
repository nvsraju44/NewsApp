import Foundation
@testable import NewsApp

class NewsViewSpy: NewsView {
    var displayNavigationTitle: String?
    
    
    func displayNavigationBar(title: String) {
        displayNavigationTitle = title
    }
    
}
