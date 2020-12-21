import UIKit
import FeedFeature

final class FeedRefreshViewController: NSObject {
	var delegate: FeedViewControllerDelegate?
	@IBOutlet var refreshControl: UIRefreshControl?
	@IBOutlet var errorView: ErrorView?

	@IBAction func refresh() {
		delegate?.didRequestFeedRefresh()
	}
}

extension FeedRefreshViewController: FeedLoadingView {

	func display(_ viewModel: FeedLoadingViewModel) {
		if viewModel.isLoading {
			refreshControl?.beginRefreshing()
		} else {
			refreshControl?.endRefreshing()
		}
	}
}


extension FeedRefreshViewController: FeedErrorView {

	func display(_ viewModel: FeedErrorViewModel) {
		if let message = viewModel.message {
			errorView?.show(message: message)
		} else {
			errorView?.hideMessage()
		}
	}
}
