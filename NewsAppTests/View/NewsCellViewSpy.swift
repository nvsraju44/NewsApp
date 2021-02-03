import Foundation
@testable import NewsApp

final class NewsCellViewSpy: NewsCellView {
    var displayedTitle = ""
    var displayedDescription = ""
    
   func display(title: String) {
        displayedTitle = title
    }
    
    func display(description : String) {
        displayedDescription = description
    }
}
