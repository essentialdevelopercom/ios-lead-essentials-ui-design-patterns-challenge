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
	var onFeedLoadError: Observer<String>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(_):
				if let feed = try? result.get() {
					self.onFeedLoad?(feed)
				}
			case let .failure(error):
				self.onFeedLoadError?(self.fetchErrorMessage(from: error as NSError))
			}
			
			self.onLoadingStateChange?(false)
		}
	}
	
	private func fetchErrorMessage(from error: NSError) -> String {
		let errorDict: [Int: String] =
			[401: "UNAUTHORIZED_ERROR".localizedString(),
			 403: "BAD_REQUEST_ERROR".localizedString(),
			 404: "SERVER_NOT_FOUND_ERROR".localizedString(),
			 503: "SERVICE_UNAVAILABLE_ERROR".localizedString(),
			 504: "TIMEOUT_ERROR".localizedString()]
		return errorDict[error.code] ?? "OTHER_ERROR".localizedString()
	}
}
