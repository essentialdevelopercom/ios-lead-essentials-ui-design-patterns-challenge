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

protocol FeedLoadErrorView {
	func display(_ viewModel: FeedLoadErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let loadErrorView: FeedLoadErrorView
	
	init(feedView: FeedView, loadingView: FeedLoadingView, loadErrorView: FeedLoadErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.loadErrorView = loadErrorView
	}
	
	func didStartLoadingFeed() {
		loadErrorView.display(FeedLoadErrorViewModel(message: .none))
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
		loadErrorView.display(FeedLoadErrorViewModel(message: Localized.Feed.loadError))
	}
}
