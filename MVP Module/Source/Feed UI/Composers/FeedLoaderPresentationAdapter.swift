//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import FeedFeature
import Foundation

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
	private let feedLoader: FeedLoader
	var presenter: FeedPresenter?
	
	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}
	
	func didRequestFeedRefresh() {
		presenter?.didStartLoadingFeed()
		
		feedLoader.load { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(feed):
				self.presenter?.didFinishLoadingFeed(with: feed)
				
			case let .failure(error):
				self.presenter?.didFinishLoadingFeed(with: error)
			}
		}
	}
}

public extension String {
	func localizedString() -> String {
		let bundle = Bundle(for: FeedViewController.self)
		let localizedString = bundle.localizedString(forKey: self, value: nil, table: "Feed")
		return localizedString
	}
}
