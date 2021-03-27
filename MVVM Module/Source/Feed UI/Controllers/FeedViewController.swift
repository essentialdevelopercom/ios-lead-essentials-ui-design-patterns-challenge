//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
	public enum LoadError {
		case Bad_Request
		case UnAuthorized
		case ServerNotFound
		case Service_Unavailable
		case Timeout
		case Other
	}
	
	@IBOutlet public var errorView: ErrorView?
	
	var viewModel: FeedViewModel? {
		didSet { bind() }
	}
	
	var tableModel = [FeedImageCellController]() {
		didSet { tableView.reloadData() }
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		refresh()
	}
	
	public func showError(_ errorMessage: LoadError) {
		let errorDict: [LoadError: String] =
			[.Bad_Request: "BAD_REQUEST_ERROR".localizedString(),
			 .UnAuthorized: "UNAUTHORIZED_ERROR".localizedString(),
			 .ServerNotFound: "SERVER_NOT_FOUND_ERROR".localizedString(),
			 .Service_Unavailable: "SERVICE_UNAVAILABLE_ERROR".localizedString(),
			 .Timeout: "TIMEOUT_ERROR".localizedString()]
				
		errorView?.show(message: errorDict[errorMessage] ?? "OTHER_ERROR".localizedString())
	}
	
	@IBAction private func refresh() {
		errorView?.hideMessage()
		viewModel?.loadFeed()
	}
	
	func bind() {
		title = viewModel?.title
		viewModel?.onLoadingStateChange = { [weak self] isLoading in
			if isLoading {
				self?.refreshControl?.beginRefreshing()
			} else {
				self?.refreshControl?.endRefreshing()
			}
		}
	}
	
	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		tableView.sizeTableHeaderToFit()
	}
	
	public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableModel.count
	}
	
	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cellController(forRowAt: indexPath).view(in: tableView)
	}
	
	public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cancelCellControllerLoad(forRowAt: indexPath)
	}
	
	public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach { indexPath in
			cellController(forRowAt: indexPath).preload()
		}
	}
	
	public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach(cancelCellControllerLoad)
	}
	
	private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
		return tableModel[indexPath.row]
	}
	
	private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
		cellController(forRowAt: indexPath).cancelLoad()
	}
}

public extension String {
	func localizedString() -> String {
		let bundle = Bundle(for: FeedViewController.self)
		let localizedString = bundle.localizedString(forKey: self, value: nil, table: "Feed")
		return localizedString
	}
}
