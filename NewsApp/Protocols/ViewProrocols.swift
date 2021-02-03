import Foundation

protocol NewsView:class {
    func refreshNewsView()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func displayNewsRetrievalError(title: String,  message:String)
    func displayNavigationBar(title: String)
}

protocol NewsCellView {
    func display(title: String)
    func display(description: String)
}

protocol NewsPresenterDelegate {
    var numberOfAricles: Int { get }
    func loadView()
    func pullToRefreshedPressed()
}
