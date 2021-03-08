//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

protocol FeedLoadingError{
	func display(_ viewModel: FeedErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let loadingError: FeedLoadingError

	init(feedView: FeedView, loadingView: FeedLoadingView, loadingError: FeedLoadingError) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.loadingError = loadingError
	}
	
	func didStartLoadingFeed() {
		loadingError.display(FeedErrorViewModel(errorMSG: nil))
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))

	}
	
	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
		loadingError.display(FeedErrorViewModel(errorMSG: Localized.Feed.loadError))
	}
}
