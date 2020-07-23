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

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onFeedFailed: Observer<String>?
    
	func loadFeed() {
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
            do {
                let feed = try result.get()
                self?.onFeedLoad?(feed)
            } catch {
                self?.onFeedFailed?("Couldn't connect to server")
            }
			self?.onLoadingStateChange?(false)
		}
	}
}

