import Foundation

protocol NewsView:class {
    func displayNavigationBar(title: String)
}

protocol NewsPresenterDelegate {
    func loadView()
}

final class NewsPresenter:NewsPresenterDelegate {
  
    // MARK: - Private Properties
    private weak var view: NewsView?
    
    // MARK: - Initialization
    init (view:NewsView) {
        self.view = view
    }
    
    func loadView() {
        view?.displayNavigationBar(title: "News")
      }
}
