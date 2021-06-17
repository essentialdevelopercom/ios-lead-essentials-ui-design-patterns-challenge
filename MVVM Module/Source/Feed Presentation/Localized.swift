//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation

final class Localized {
	static var bundle: Bundle {
		Bundle(for: Localized.self)
	}
}

extension Localized {
	enum Feed {
		static var table: String { "Feed" }

		static var title: String {
			NSLocalizedString(
				"FEED_VIEW_TITLE",
				tableName: table,
				bundle: bundle,
				comment: "Title for the feed view")
		}

		static var loadError: String {
			NSLocalizedString(
				"FEED_VIEW_CONNECTION_ERROR",
				tableName: table,
				bundle: bundle,
				comment: "Error message displayed when we can't load the image feed from the server")
		}
	}
}
