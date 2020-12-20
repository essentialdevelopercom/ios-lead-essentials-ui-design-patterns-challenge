import UIKit
import FeedFeature

final class FeedRefreshViewController: NSObject {
	var delegate: FeedViewControllerDelegate?
	@IBOutlet var view: UIRefreshControl?
	@IBOutlet var errorView: ErrorView?

	@IBAction func refresh() {
		delegate?.didRequestFeedRefresh()
	}
}

extension FeedRefreshViewController: FeedLoadingView {

	func display(_ viewModel: FeedLoadingViewModel) {
		if viewModel.isLoading {
			view?.beginRefreshing()
		} else {
			view?.endRefreshing()
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
