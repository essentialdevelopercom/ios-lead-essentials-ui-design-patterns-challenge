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
    
    let loadingErrorMessage = NSLocalizedString("FEED_VIEW_CONNECTION_ERROR", tableName: "Feed", bundle: Bundle(for: FeedViewModel.self), comment: "Message to display when the feed loading fails")

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onErrorStateChange: Observer<String?>?
    
	func loadFeed() {
		onLoadingStateChange?(true)
        onErrorStateChange?(nil)
		feedLoader.load { [weak self] result in
            guard let self = self else { return }
            
            if let feed = try? result.get() {
				self.onFeedLoad?(feed)
            } else {
                self.onErrorStateChange?(self.loadingErrorMessage)
            }
			self.onLoadingStateChange?(false)
		}
	}
}

