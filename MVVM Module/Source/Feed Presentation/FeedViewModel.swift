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
		self.onErrorStateChange?(nil)
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let feeds):
				self.onFeedLoad?(feeds)
			case .failure(_):
				self.onErrorStateChange?("FEED_VIEW_CONNECTION_ERROR".localizedString())
			}
			
			self.onLoadingStateChange?(false)
		}
	}
}

extension String {
	func localizedString() -> String {
		let bundle = Bundle(for: FeedViewController.self)
		let localizedString = bundle.localizedString(forKey: self, value: nil, table: "Feed")
		return localizedString
	}
}
