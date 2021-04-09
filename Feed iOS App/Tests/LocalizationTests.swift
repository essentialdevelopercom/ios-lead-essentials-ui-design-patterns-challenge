//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import XCTest
import MVC
import MVVM
import MVP
import FeediOSApp

final class LocalizationTests: XCTestCase {
	func test_allModules_haveLocalizedResourcesForAllSupportedLocalizations() {
		let moduleLocalizations: [(module: String, localizations: Set<String>)] = [
			("FeediOSApp", localizations(for: FeediOSApp.AppDelegate.self)),
			("MVC", localizations(for: MVC.FeedViewController.self)),
			("MVVM", localizations(for: MVVM.FeedViewController.self)),
			("MVP", localizations(for: MVP.FeedViewController.self))
		]

		let allSupportedLocalizations = moduleLocalizations
			.reduce(Set<String>()) { acc, e in
				acc.union(e.localizations)
			}

		moduleLocalizations.forEach { module, localizations in
			let missingLocalizations = allSupportedLocalizations.subtracting(localizations)

			if !missingLocalizations.isEmpty {
				XCTFail("Missing \(missingLocalizations) localization(s) in module: \(module)")
			}
		}
	}

	// MARK: - Helpers

	private func localizations(for type: AnyClass) -> Set<String> {
		let bundle = Bundle(for: type)
		let localizations = bundle.localizations.filter { $0 != "Base" }
		return Set(localizations)
	}
}
