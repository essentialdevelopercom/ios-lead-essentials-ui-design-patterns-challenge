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
	var onFeedLoadError: Observer<FeedViewController.LoadError>?
	
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
				self.onFeedLoadError?(self.mapToLoadError(error as NSError))
			}
			
			self.onLoadingStateChange?(false)
		}
	}
	
	private func mapToLoadError(_ error: NSError) -> FeedViewController.LoadError {
		let errors: [Int: FeedViewController.LoadError] = [
			403: .Bad_Request,
			401: .UnAuthorized,
			404: .ServerNotFound,
			503: .Service_Unavailable,
			504: .Timeout]
		return errors[error.code] ?? .Other
	}
}
