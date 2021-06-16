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

	var onLoadingStateChange: Observer<Bool>?
	var onLoadingError: Observer<String?>?
	var onFeedLoad: Observer<[FeedImage]>?

	func loadFeed() {
		onLoadingStateChange?(true)
		onLoadingError?(nil)
		feedLoader.load { [weak self] result in
			if let feed = try? result.get() {
				self?.onFeedLoad?(feed)
			} else {
				self?.onLoadingError?(Localized.Feed.loadError)
			}
			self?.onLoadingStateChange?(false)
		}
	}
}
