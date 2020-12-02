
import UIKit
import FeedFeature

final class FeedRefreshController: NSObject {
    
    @IBOutlet var view: UIRefreshControl?
    @IBOutlet var errorView: ErrorView?
    
    var viewModel: FeedRefreshViewModel? {
        didSet {
            bind()
        }
    }
    
    @IBAction func refresh() {
        errorView?.hideMessage()
        viewModel?.refreshFeed()
    }
    
    private func bind() {
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            if isLoading {
                self?.view?.beginRefreshing()
            } else {
                self?.view?.endRefreshing()
            }
        }
        
        viewModel?.onFeedError = { [weak self] errorMessage in
            self?.errorView?.show(message: errorMessage)
        }
    }
    
}
