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

	enum LoadingState {
		case loaded
		case pending
		case error(String)
	}

	var onLoadingStateChange: Observer<LoadingState>?
	var onFeedLoad: Observer<[FeedImage]>?

	func loadFeed() {
		onLoadingStateChange?(.pending)
		feedLoader.load { [weak self] result in
			do {
				let feed = try result.get()
				self?.onFeedLoad?(feed)
				self?.onLoadingStateChange?(.loaded)
			} catch {
				self?.onLoadingStateChange?(.error(Localized.Feed.loadError))
			}
		}
	}
}
