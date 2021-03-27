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
		let errorCode = (error as NSError).code
		return (LoadError(errorCode).rawValue).localizedString()
	}
}

enum LoadError: String {
	case Unauthorized = "UNAUTHORIZED_ERROR"
	case BadRequest = "BAD_REQUEST_ERROR"
	case ServerNotFound = "SERVER_NOT_FOUND_ERROR"
	case ServiceUnavailable = "SERVICE_UNAVAILABLE_ERROR"
	case Timeout = "TIMEOUT_ERROR"
	case Other = "OTHER_ERROR"
	
	init(_ errorCode: Int) {
		let errorMessages: [Int: LoadError] = [
			401: .Unauthorized,
			403: .BadRequest,
			404: .ServerNotFound,
			503: .ServiceUnavailable,
			504: .Timeout]
		self = errorMessages[errorCode] ?? .Other
	}
}
