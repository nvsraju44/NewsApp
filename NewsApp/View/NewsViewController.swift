import UIKit

final class NewsViewController: UITableViewController  {
        
    private var safeArea : UILayoutGuide!
    private var presenter: NewsPresenter!
    
    override func loadView() {
        super.loadView()
        safeArea = view.layoutMarginsGuide
        presenter = NewsPresenter(view:self)

        presenter.loadView()
    }
    // MARK: - Private Methods

}
extension NewsViewController :NewsView {
    
    func displayNavigationBar(title: String) {
        self.title = title
    }
}

