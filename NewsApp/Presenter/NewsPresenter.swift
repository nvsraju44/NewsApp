import Foundation

final class NewsPresenter :NewsPresenterDelegate {
    
    // MARK: - Private Properties
    private weak var view: NewsView?
    private let delegate: DisplayNews
    private var newsArticles = [Article]()
    
    var numberOfAricles: Int {
        return newsArticles.count
    }
    
    // MARK: - Initialization
    init (view:NewsView, delegate:DisplayNews) {
        self.view = view
        self.delegate = delegate
    }
    // MARK: - Public Methods
    func loadView() {
        view?.displayNavigationBar(title: "News")
        fetchNews()
    }
    
    func pullToRefreshedPressed() {
        fetchNews()
    }
    
    func configure(cell: NewsCellView, forRow row: Int) {
        let article = newsArticles[row]
        
        if let title = article.title {
            cell.display(title: title)
        }
        if let description = article.description {
            cell.display(description: description)
        }
    }
    
    
    // MARK: - Private Methods
    private func fetchNews() {
        
        view?.showLoadingIndicator()
        delegate.displayNews { (result) in
            switch result {
            case let .success(articles):
                self.handleNewsReceived(articles)
            case let .failure(error):
                self.handleNewsError(error)
            }
        }
    }
    
    private func handleNewsReceived(_ news: [Article]) {
        self.newsArticles = news
        view?.refreshNewsView()
        view?.hideLoadingIndicator()
    }
    
    private func handleNewsError(_ error: Error) {
        view?.displayNewsRetrievalError(title: "Error", message: error.localizedDescription)
        view?.hideLoadingIndicator()
    }
}
