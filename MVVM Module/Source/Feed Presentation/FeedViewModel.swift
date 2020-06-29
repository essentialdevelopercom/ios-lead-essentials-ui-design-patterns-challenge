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
    
    private var errorMessage: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
            tableName: "Feed",
            bundle: Bundle(for: FeedViewModel.self),
            comment: "Message for the error view")
    }

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onLoadingErrorStateChange: Observer<String?>?
	
	func loadFeed() {
        onLoadingErrorStateChange?(nil)
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
			if let feed = try? result.get() {
				self?.onFeedLoad?(feed)
            } else {
                self?.onLoadingErrorStateChange?(self?.errorMessage)
            }
			self?.onLoadingStateChange?(false)
		}
	}
}

