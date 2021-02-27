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

protocol ErrorPresentingView {
	func display(_ viewModel: ErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let errorPresentingView: ErrorPresentingView
	
	init(feedView: FeedView, loadingView: FeedLoadingView, errorPresentingView: ErrorPresentingView) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.errorPresentingView = errorPresentingView
	}
	
	func didStartLoadingFeed() {
		errorPresentingView.display(ErrorViewModel(message: nil))
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		errorPresentingView.display(ErrorViewModel(message: Localized.Feed.loadError))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
