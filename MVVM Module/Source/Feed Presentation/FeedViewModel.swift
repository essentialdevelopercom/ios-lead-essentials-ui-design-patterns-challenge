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
				self.onFeedLoadError?(self.getCustomizedErrorText(from: error as NSError))
			}
			
			self.onLoadingStateChange?(false)
		}
	}
	
	private func getCustomizedErrorText(from error: NSError) -> String {
		let errorCode = (error as NSError).code
		return (CustomError(errorCode).rawValue).localizedString()
	}
}

enum CustomError: String {
	case Unauthorized = "UNAUTHORIZED_ERROR"
	case BadRequest = "BAD_REQUEST_ERROR"
	case ServerNotFound = "SERVER_NOT_FOUND_ERROR"
	case ServiceUnavailable = "SERVICE_UNAVAILABLE_ERROR"
	case Timeout = "TIMEOUT_ERROR"
	case Other = "OTHER_ERROR"
	
	init(_ errorCode: Int) {
		let errorMessages: [Int: CustomError] = [
			401: .Unauthorized,
			403: .BadRequest,
			404: .ServerNotFound,
			503: .ServiceUnavailable,
			504: .Timeout]
		self = errorMessages[errorCode] ?? .Other
	}
}
