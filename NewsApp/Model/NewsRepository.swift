import Foundation

typealias FetchNewsListCompletionHandler = (_ news: Result<NewsList>) -> Void

protocol NewsRepository {
    func fetchNews(completionHandler: @escaping FetchNewsListCompletionHandler)
}

final class NewsRepo: NewsRepository {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    func fetchNews(completionHandler: @escaping (Result<NewsList>) -> Void) {
        let newsApiRequest = NewsAPIRequest()
        apiClient.execute(request: newsApiRequest) { (result: Result<ApiParseResponse<NewsList>>) in
            switch result {
            case let .success(response):
                let news = response.source
                completionHandler(.success(news))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
