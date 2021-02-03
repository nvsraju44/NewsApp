import UIKit

final class NewsViewController: UITableViewController  {
    
    var presenter: NewsPresenter!
    var configuration: NewsConfiguration!
    private var activityIndicator: UIActivityIndicatorView!
    private var pullToRefresh : UIRefreshControl!
    
    override func loadView() {
        super.loadView()
        configuration = NewsConfiguration(newsViewController: self)
        registerCells()
        createActivityIndicator()
        createdRefreshControl()
        self.refreshControl = pullToRefresh
        presenter.loadView()

    }
    
    // MARK: - Private Method
    private func registerCells() {
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    private func createdRefreshControl() {
        pullToRefresh = UIRefreshControl()
        pullToRefresh.addTarget(self, action: #selector(self.refreshTableViewData(_:)), for: .valueChanged)

    }
    @objc private func refreshTableViewData(_ sender: UIRefreshControl) {
        presenter.pullToRefreshedPressed()
       
    }
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfAricles
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("News Cell not found")
        }
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
}

// MARK: - NewsView

extension NewsViewController :NewsView {
    
    func showLoadingIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    func hideLoadingIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func displayNewsRetrievalError(title: String, message: String) {
        self.title = title
    }
    
    func refreshNewsView() {
        tableView.reloadData()
        pullToRefresh.endRefreshing()
    }
    
    func displayNavigationBar(title: String) {
        self.title = title
    }
}
