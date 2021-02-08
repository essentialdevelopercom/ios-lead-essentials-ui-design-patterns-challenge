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

    private var errorMessage: String {
        return Localized.Feed.loadError
    }

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onErrorMessage: Observer<String>?

	func loadFeed() {
		onLoadingStateChange?(true)
		feedLoader.load { [weak self, errorMessage] result in
            switch result {
            case .success(let feed):
                self?.onFeedLoad?(feed)
            case .failure:
                self?.onErrorMessage?(errorMessage)
            }

			self?.onLoadingStateChange?(false)
		}
	}
}

