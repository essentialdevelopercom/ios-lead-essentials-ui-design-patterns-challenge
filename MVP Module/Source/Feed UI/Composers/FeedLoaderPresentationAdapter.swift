//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import FeedFeature
import Foundation

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
	private let feedLoader: FeedLoader
	var presenter: FeedPresenter?
	
	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}
	
	func didRequestFeedRefresh() {
		presenter?.didStartLoadingFeed()
		
		feedLoader.load { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(feed):
				self.presenter?.didFinishLoadingFeed(with: feed)
				
			case let .failure(error):
				let errorText = self.mapToLoadError((error as NSError))
				self.presenter?.didFinishLoadingFeed(with: errorText)
			}
		}
	}
	
	private func mapToLoadError(_ error: Error) -> String {
		let errorMessages: [Int: String] = [
			401: "UNAUTHORIZED_ERROR".localizedString(),
			403: "BAD_REQUEST_ERROR".localizedString(),
			404: "SERVER_NOT_FOUND_ERROR".localizedString(),
			503: "SERVICE_UNAVAILABLE_ERROR".localizedString(),
			504: "TIMEOUT_ERROR".localizedString()]
		return errorMessages[(error as NSError).code] ?? "OTHER_ERROR".localizedString()
	}
}
