//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

final class FeedViewModel {
	typealias Observer<T> = (T) -> Void

	private let feedLoader: FeedLoader

	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}

	var title: String {
		Localized.Feed.title
	}

	var loadError: String {
		Localized.Feed.loadError
	}

	var onFeedLoad: Observer<[FeedImage]>?
	var onLoadingStateChange: Observer<Bool>?
	var onErrorStateChange: Observer<String?>?

	func loadFeed() {
		onLoadingStateChange?(true)
		onFeedError?(nil)
		feedLoader.load { [weak self] result in
			switch result {
			case let .success(feed):
				self?.onFeedLoad?(feed)
			case .failure:
				self?.onFeedError?(self?.loadError)
			}
			self?.onLoadingStateChange?(false)
		}
	}
}
