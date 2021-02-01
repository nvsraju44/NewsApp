import Foundation

protocol NewsView:class {
}

final class NewsPresenter {
    
    private weak var view: NewsView?
    
    init (view:NewsView) {
        self.view = view
    }
}
