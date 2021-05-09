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
	var onFeedLoad: Observer<[FeedImage]>?
	var onFeedError: Observer<String?>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
		onFeedError?(.none)
		feedLoader.load { [weak self] result in
			switch result {
			case .failure:
				self?.onFeedError?(Localized.Feed.loadError)
			case let .success(feed):
				self?.onFeedLoad?(feed)
			}
			self?.onLoadingStateChange?(false)
		}
	}
}

