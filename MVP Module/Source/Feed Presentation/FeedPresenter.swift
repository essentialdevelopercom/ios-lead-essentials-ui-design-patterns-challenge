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

protocol FeedLoadingErrorView {
    func display(_ viewModel: FeedLoadingErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
    private let loadingErrorView: FeedLoadingErrorView

    init(feedView: FeedView, loadingView: FeedLoadingView, loadingErrorView: FeedLoadingErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
        self.loadingErrorView = loadingErrorView
	}
    
	func didStartLoadingFeed() {
        loadingErrorView.display(FeedLoadingErrorViewModel.noError)
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
        loadingErrorView.display(FeedLoadingErrorViewModel.errorMessage)
	}
}
