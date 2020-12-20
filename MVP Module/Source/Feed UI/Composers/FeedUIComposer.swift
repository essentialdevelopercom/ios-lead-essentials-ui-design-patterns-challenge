//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

public final class FeedUIComposer {
	private init() {}
	
	public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
		let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader:
																	MainQueueDispatchDecorator(decoratee: feedLoader))
		
		let feedController = makeFeedViewController(title: Localized.Feed.title)

		feedController.refreshController?.delegate = presentationAdapter
		presentationAdapter.presenter = FeedPresenter(
			feedView: FeedViewAdapter(
				controller: feedController,
				imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)),
			loadingView: WeakRefVirtualProxy(feedController.refreshController!),
			errorView: WeakRefVirtualProxy(feedController.refreshController!))
		
		return feedController
	}
	
	private static func makeFeedViewController(title: String) -> FeedViewController {
		let bundle = Bundle(for: FeedViewController.self)
		let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
		let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
		feedController.title = title
		return feedController
	}
}
