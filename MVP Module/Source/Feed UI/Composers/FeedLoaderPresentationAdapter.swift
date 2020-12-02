//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import FeedFeature

final class FeedLoaderPresentationAdapter: FeedRefreshControllerDelegate {
	private let feedLoader: FeedLoader
	var presenter: FeedPresenter?
    var refreshPresenter: FeedRefreshPresenter?
	
	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}
	
	func didRequestFeedRefresh() {
        refreshPresenter?.didStartLoadingFeed()
		
		feedLoader.load { [weak self] result in
			switch result {
			case let .success(feed):
				self?.presenter?.didFinishLoadingFeed(with: feed)
                self?.refreshPresenter?.didFinishLoadingFeed()
			case let .failure(error):
				self?.refreshPresenter?.didFinishLoadingFeed(with: error)
			}
		}
	}
}
