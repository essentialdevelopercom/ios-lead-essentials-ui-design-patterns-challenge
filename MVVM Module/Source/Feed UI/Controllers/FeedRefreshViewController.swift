
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
        bindLoadingStateChange()
        bindErrorStateChange()
    }
    
    private func bindLoadingStateChange() {
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            if isLoading {
                self?.view?.beginRefreshing()
            } else {
                self?.view?.endRefreshing()
            }
        }
    }
    
    private func bindErrorStateChange() {
        viewModel?.onErrorStateChange = { [weak self] errorMessage in
            if let message = errorMessage {
                self?.errorView?.show(message: message)
            } else {
                self?.errorView?.hideMessage()
            }
        }
    }
    
}
