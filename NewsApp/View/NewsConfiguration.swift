import Foundation

protocol NewsConfigurator {
     init(newsViewController: NewsViewController)
}

final class NewsConfiguration: NewsConfigurator {
    
    required init(newsViewController: NewsViewController) {
        
        let apiClient = ApiClient(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
        let newsRepo = NewsRepo(apiClient: apiClient)
                
        let newsService = DisplayNewsService(newsRepo: newsRepo)
        
        let presenter = NewsPresenter(view: newsViewController, delegate:newsService)
        
        newsViewController.presenter = presenter
    }
}
