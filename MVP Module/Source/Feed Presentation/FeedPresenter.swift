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

 struct FeedErrorViewModel {
     let errorMessage: String?
 }

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
    private let feedErrorView: FeedErrorView
    
    private var errorMessage: String {
         Localized.Feed.loadError
     }
	
    init(feedView: FeedView, loadingView: FeedLoadingView, feedErrorView: FeedErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
        self.feedErrorView = feedErrorView
	}
    
	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
        feedErrorView.display(FeedErrorViewModel(errorMessage: nil))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
        feedErrorView.display(FeedErrorViewModel(errorMessage: errorMessage))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
