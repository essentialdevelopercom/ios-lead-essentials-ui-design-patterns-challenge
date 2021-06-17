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
	var onErrorStateChange: Observer<String?>?
	var onFeedLoad: Observer<[FeedImage]>?

	func loadFeed() {
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
			do {
				let feed = try result.get()
				self?.onFeedLoad?(feed)
			} catch {
				self?.onErrorStateChange?(Localized.Feed.loadError)
			}
			self?.onLoadingStateChange?(false)
		}
	}
}
