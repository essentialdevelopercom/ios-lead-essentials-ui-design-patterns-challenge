
import UIKit
import FeedFeature

protocol FeedRefreshControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshController: NSObject, FeedRefreshView, FeedErrorView {
    
    @IBOutlet var view: UIRefreshControl?
    @IBOutlet var errorView: ErrorView?
    
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
    
    func display(_ viewModel: FeedErrorViewModel) {
        if let errorMessage = viewModel.errorMessage {
            errorView?.show(message: errorMessage)
        } else {
            errorView?.hideMessage()
        }
    }
    
}
