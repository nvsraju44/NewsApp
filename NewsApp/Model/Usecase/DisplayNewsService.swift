import Foundation

typealias DisplayNewsCompletionHandler = (_ news: Result<[Article]>) -> Void

protocol DisplayNews {
     func displayNews(completionHandler: @escaping DisplayNewsCompletionHandler)
}

final class DisplayNewsService: DisplayNews {
    let newsRepo: NewsRepository
    
    init(newsRepo: NewsRepository) {
        self.newsRepo = newsRepo
    }
    
    func displayNews(completionHandler:@escaping (Result<[Article]>) -> Void) {
        self.newsRepo.fetchNews { (result) in
            completionHandler(result.map { $0.articles})
        }
    }
}
