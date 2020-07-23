//
// Copyright © 2020 Essential Developer. All rights reserved.
//

import UIKit

final class FeedRefreshViewController: NSObject {
    @IBOutlet var view: UIRefreshControl?
    @IBOutlet var errorView: ErrorView?
    
    var viewModel: FeedViewModel? {
        didSet { bind() }
    }

    @IBAction func refresh() {
        viewModel?.loadFeed()
    }
    
    private func bind() {
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            if isLoading {
                self?.errorView?.hideMessage()
                self?.view?.beginRefreshing()
            } else {
                self?.view?.endRefreshing()
            }
        }
        
        viewModel?.onFeedFailed = { [weak self] message in
            self?.errorView?.show(message: message)
        }
    }
}
