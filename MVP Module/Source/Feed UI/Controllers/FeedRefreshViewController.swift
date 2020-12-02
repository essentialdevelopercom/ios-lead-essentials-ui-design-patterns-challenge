
import UIKit
import FeedFeature

protocol FeedRefreshControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshController: NSObject, FeedRefreshView {
    
    @IBOutlet var view: UIRefreshControl?
    @IBOutlet var errorView: ErrorView?
    
    var delegate: FeedRefreshControllerDelegate?
    
    @IBAction func refresh() {
        errorView?.hideMessage()
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
        
        if let errorMessage = viewModel.errorMessage {
            errorView?.show(message: errorMessage)
        }
    }
    
}
