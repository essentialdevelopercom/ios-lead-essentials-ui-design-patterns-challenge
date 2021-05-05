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

protocol FeedErrorView {
	func display(_ viewModel: FeedErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let feedErrorView: FeedErrorView
	private let loadingView: FeedLoadingView

	init(feedView: FeedView, feedErrorView: FeedErrorView, loadingView: FeedLoadingView) {
		self.feedView = feedView
		self.feedErrorView = feedErrorView
		self.loadingView = loadingView
	}

	func didStartLoadingFeed() {
		feedErrorView.display(FeedErrorViewModel(errorMessage: nil))
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}

	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}

	func didFinishLoadingFeed(with error: Error) {
		feedErrorView.display(FeedErrorViewModel(errorMessage: Localized.Feed.error))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
