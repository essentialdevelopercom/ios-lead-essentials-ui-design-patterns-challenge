//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

final class FeedRefreshViewController: NSObject {
    var viewModel: FeedViewModel?
    
    @IBOutlet var refreshControl: UIRefreshControl! {
        didSet {
            bind(refreshControl)
        }
    }
    
    @IBOutlet var errorView: ErrorView! {
        didSet {
            bind(errorView)
        }
    }
    
    @objc func refresh() {
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
        viewModel?.onErrorStateChange = { message in
            if let message = message, !message.isEmpty {
                errorView?.show(message: message)
            } else {
                errorView?.hideMessage()
            }
        }
    }
}
