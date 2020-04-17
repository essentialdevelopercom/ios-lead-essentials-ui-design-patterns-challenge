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
    
    var errorMessage: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
            tableName: "Feed",
            bundle: Bundle(for: FeedViewModel.self),
            comment: "Error message on error loading feed")
    }

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onErrorLoadingFeed: Observer<String?>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
        onErrorLoadingFeed?(nil)
		feedLoader.load { [weak self] result in
            guard let self = self else { return }
            
            self.onLoadingStateChange?(false)
            guard let feed = try? result.get() else {
                self.onErrorLoadingFeed?(self.errorMessage)
                return
            }
			self.onFeedLoad?(feed)
		}
	}
}

