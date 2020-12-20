import UIKit
import FeedFeature

final class FeedRefreshViewController: NSObject {
	@IBOutlet var view: UIRefreshControl?
	@IBOutlet var errorView: ErrorView?

	var viewModel: FeedViewModel? {
		didSet { bind() }
	}

	@IBAction func refresh() {
		viewModel?.loadFeed()
	}

	func bind() {
		viewModel?.onLoadingStateChange = { [weak self] isLoading in
			if isLoading {
				self?.view?.beginRefreshing()
			} else {
				self?.view?.endRefreshing()
			}
		}

		viewModel?.onErrorStateChange = { [weak self] errorMessage in
			if let message = errorMessage {
				self?.errorView?.show(message: message)
			} else {
				self?.errorView?.hideMessage()
			}
		}
	}

}
