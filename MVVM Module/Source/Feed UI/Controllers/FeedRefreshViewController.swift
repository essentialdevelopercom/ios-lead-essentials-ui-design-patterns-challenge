//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

final class FeedRefreshViewController: NSObject {
    var viewModel: FeedViewModel?
    
    var refreshControl: UIRefreshControl? {
        didSet {
            bind(refreshControl)
        }
    }
    
    var errorView: ErrorView? {
        didSet {
            bind(errorView)
        }
    }
    
    @objc func refresh() {
        errorView?.hideMessage()
        viewModel?.loadFeed()
    }
    
    private func bind(_ refreshControl: UIRefreshControl?) {
        viewModel?.onLoadingStateChange = { isLoading in
            if isLoading {
                refreshControl?.beginRefreshing()
            } else {
                refreshControl?.endRefreshing()
            }
        }
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func bind(_ errorView: ErrorView?) {
        viewModel?.onFeedError = { message in
            errorView?.show(message: message)
        }
    }
}
