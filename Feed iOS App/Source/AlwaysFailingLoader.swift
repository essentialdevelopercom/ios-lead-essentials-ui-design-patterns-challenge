//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

public final class AlwaysFailingLoader {
	private let delay: TimeInterval
	private let queue = DispatchQueue(label: "AlwaysFailingLoader.background-queue")

	public init(delay: TimeInterval) {
		self.delay = delay
	}
}

extension AlwaysFailingLoader: FeedLoader {
	private struct LoadError: Error {}

	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		queue.asyncAfter(deadline: .now() + delay) {
			completion(.failure(LoadError()))
		}
	}
}

extension AlwaysFailingLoader: FeedImageDataLoader {
	private final class Task: FeedImageDataLoaderTask {
		func cancel() {}
	}

	public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
		queue.asyncAfter(deadline: .now() + delay) {
			completion(.failure(LoadError()))
		}
		return Task()
	}
}
