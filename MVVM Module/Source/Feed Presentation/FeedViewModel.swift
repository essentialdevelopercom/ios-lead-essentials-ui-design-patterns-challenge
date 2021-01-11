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
    var onErrorStateChange: Observer<String?>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
        onErrorStateChange?(.none)
		feedLoader.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(feed):
                self.onFeedLoad?(feed)
            case .failure:
                self.onErrorStateChange?(Localized.Feed.errorMessage)
            }
			self.onLoadingStateChange?(false)
		}
	}
}

