//
//  FeedRefreshViewController.swift
//  MVVM
//
//  Created by Alex Thurston on 6/16/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

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
		viewModel?.onLoadingStateChange = { [weak self] loadingState in
			switch loadingState {
			case .loaded:
				self?.errorView?.hideMessage()
				self?.view?.endRefreshing()
			case .pending:
				self?.errorView?.hideMessage()
				self?.view?.beginRefreshing()
			case .error(let message):
				self?.view?.endRefreshing()
				self?.errorView?.show(message: message)
			}
		}
	}
}
