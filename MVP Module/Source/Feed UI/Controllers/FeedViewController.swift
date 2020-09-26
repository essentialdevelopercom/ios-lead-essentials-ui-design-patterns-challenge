//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

protocol FeedViewControllerDelegate {
	func didRequestFeedRefresh()
}

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView {
	var delegate: FeedViewControllerDelegate?
	
	private var tableModel = [FeedImageCellController]() {
		didSet { tableView.reloadData() }
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		
		refresh()
	}
	
    @IBOutlet weak var errorView: ErrorView!
    
    @IBAction private func refresh() {
		delegate?.didRequestFeedRefresh()
	}
	
	func display(_ viewModel: FeedLoadingViewModel) {
		if viewModel.isLoading {
			refreshControl?.beginRefreshing()
		} else {
			refreshControl?.endRefreshing()
		}
	}
    
    func display(_ cellControllers: [FeedImageCellController]) {
        tableModel = cellControllers
    }
    
    func display(_ viewModel: FeedErrorViewModel) {
        guard let errorMessage = viewModel.errorMessage else {
            errorView.hideMessage()
            return
        }
        errorView.show(message: errorMessage)
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
