
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
        displayRefreshLoader(viewModel.isLoading)
        
        if let errorMessage = viewModel.errorMessage {
            displayErrorMessage(errorMessage)
        }
    }
    
    private func displayRefreshLoader(_ isLoading: Bool) {
        if isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
    
    private func displayErrorMessage(_ message: String) {
        errorView?.show(message: message)
    }
    
}
