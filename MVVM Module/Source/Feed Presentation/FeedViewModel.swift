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
    
    var errorMessage: String {
        Localized.Feed.loadError
    }

    //MARK: - Observers
	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onError: Observer<String>?
    
	func loadFeed() {
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
            self?.process(result: result)
			self?.onLoadingStateChange?(false)
		}
	}
    
    private func process(result: Result<[FeedImage], Error>) {
        switch result {
        case .success(let feed):
            onFeedLoad?(feed)
        case .failure:
            onError?(errorMessage)
        }
    }
}

