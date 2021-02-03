import Foundation
@testable import NewsApp

final class NewsRepositorySpy : NewsRepository {
    
    var fetchNewsResultToBeReturned: Result<NewsList>!
    
    func fetchNews(completionHandler: @escaping FetchNewsListCompletionHandler) {
        completionHandler(fetchNewsResultToBeReturned)
    }
}
