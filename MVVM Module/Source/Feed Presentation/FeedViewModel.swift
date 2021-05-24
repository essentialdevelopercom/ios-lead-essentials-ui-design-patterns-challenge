//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

enum FeedErrorViewModel {
	case show(message: String)
	case hide
}

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
	var onFeedLoadFailure: Observer<FeedErrorViewModel>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
		onFeedLoadFailure?(.hide)
		feedLoader.load { [weak self] result in
			self?.handle(result)
		}
	}
	
	private func handle(_ result: FeedLoader.Result) {
		switch result {
		case let .success(feed):
			onFeedLoad?(feed)
		case .failure:
			onFeedLoadFailure?(.show(message: Localized.Feed.loadError))
		}
		
		onLoadingStateChange?(false)
	}
}
