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
		return NSLocalizedString("FEED_VIEW_TITLE",
			tableName: "Feed",
			bundle: Bundle(for: FeedViewModel.self),
			comment: "Title for the feed view")
	}
    
    var feedLoadError: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
             tableName: "Feed",
             bundle: Bundle(for: FeedViewModel.self),
             comment: "Error message displayed when we can't load the image feed from the server")
    }

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onErrorOccur: Observer<String>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
            guard let self = self else { return }
            do {
                let feed = try result.get()
                self.onFeedLoad?(feed)
            } catch {
                self.onErrorOccur?(self.feedLoadError)
            }
            self.onLoadingStateChange?(false)
		}
	}
}

