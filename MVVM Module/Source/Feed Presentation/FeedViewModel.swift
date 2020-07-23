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
        return Localized.feedTitle
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
                self?.onFeedFailed?(Localized.feedLoadError)
            }
			self?.onLoadingStateChange?(false)
		}
	}
}

