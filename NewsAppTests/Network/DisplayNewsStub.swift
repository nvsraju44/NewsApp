import Foundation

@testable import NewsApp

final class DisplayNewsStub: DisplayNews {

    var resultToBeReturned: Result<[Article]>!

    func displayNews(completionHandler: @escaping (Result<[Article]>) -> Void) {
        
        completionHandler(resultToBeReturned)
    }
}
