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
    var onFeedLoadSuccess: Observer<Bool>?
	
	func loadFeed() {
        onFeedLoadSuccess?(true)
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
			if let feed = try? result.get() {
				self?.onFeedLoad?(feed)
                self?.onFeedLoadSuccess?(true)
            } else {
                self?.onFeedLoadSuccess?(false)
            }
			self?.onLoadingStateChange?(false)
		}
	}
}

