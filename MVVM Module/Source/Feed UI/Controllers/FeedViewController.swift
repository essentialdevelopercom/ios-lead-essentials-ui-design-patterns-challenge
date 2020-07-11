//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
    @IBOutlet public private(set) var errorView: ErrorView!
    
    var viewModel: FeedViewModel? {
		didSet { bind() }
	}
	
	var tableModel = [FeedImageCellController]() {
		didSet {
            tableView.reloadData()
        }
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
        
		refresh()
	}
	
	@IBAction private func refresh() {
		viewModel?.loadFeed()
	}
	
	func bind() {
		viewModel?.onLoadingStateChange = { [weak self] isLoading in
			if isLoading {
                self?.errorView.hideMessage()
				self?.refreshControl?.beginRefreshing()
			} else {
				self?.refreshControl?.endRefreshing()
			}
		}
                        
        viewModel?.onFeedLoadFails = { [weak self] error in
            self?.errorView.show(message: "There was an error tyry again")
        }
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
