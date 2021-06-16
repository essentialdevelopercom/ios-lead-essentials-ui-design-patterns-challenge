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
		viewModel?.onLoadingStateChange = { [weak self] isLoading in
			if isLoading {
				self?.view?.beginRefreshing()
			} else {
				self?.view?.endRefreshing()
			}
		}
	}
}
