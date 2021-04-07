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
	
	enum ErrorState {
		case none
		case error(String)
	}
	
	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
	var onErrorStateChange: Observer<ErrorState>?
	
	func loadFeed() {
		onErrorStateChange?(ErrorState.none)
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
			switch result {
			case let .success(feed):
				self?.onFeedLoad?(feed)
			
			case .failure:
				self?.onErrorStateChange?(ErrorState.error(Localized.Feed.loadError))
			}
			self?.onLoadingStateChange?(false)
		}
	}
}

