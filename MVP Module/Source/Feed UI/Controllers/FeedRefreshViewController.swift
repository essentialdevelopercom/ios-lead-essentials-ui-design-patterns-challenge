
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
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        displayRefreshLoader(viewModel.isLoading)
    }
    
    func display(_ viewModel: FeedErrorViewModel) {
        handleErrorViewVisibility(viewModel.errorMessage)
    }
    
    private func displayRefreshLoader(_ isLoading: Bool) {
        if isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
    
    private func handleErrorViewVisibility(_ message: String?) {
        if let errorMessage = message {
            errorView?.show(message: errorMessage)
        } else {
            errorView?.hideMessage()
        }
    }
    
}
