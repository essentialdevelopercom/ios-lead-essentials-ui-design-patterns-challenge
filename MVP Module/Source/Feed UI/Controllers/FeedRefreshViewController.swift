
import UIKit
import FeedFeature

protocol FeedRefreshControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshController: NSObject, FeedRefreshView {
    
    @IBOutlet var view: UIRefreshControl?
    
    var delegate: FeedRefreshControllerDelegate?
    
    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
    
}
