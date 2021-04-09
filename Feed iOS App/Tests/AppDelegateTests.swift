//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import XCTest
import MVP
import MVVM
import MVC
import FeediOSApp

final class AppDelegateTests: XCTestCase {
	func test_canFinishLaunching() {
		let sut = makeSUT()

		let finished = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

		XCTAssertTrue(finished, "Expected `didFinishLaunchingWithOptions` to return true")
	}

	func test_didFinishLaunching_setsKeyWindow() {
		let sut = makeSUT()

		_ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

		XCTAssertNotNil(sut.window, "Expected AppDelegate window to be set")
		XCTAssertEqual(sut.window?.isKeyWindow, true, "Expected AppDelegate window to be key window")
	}

	func test_window_hasRootViewController() {
		let sut = makeSUT()

		_ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
		let root = sut.window?.rootViewController

		XCTAssertNotNil(root, "Expected window to have a `rootViewController`")
	}

	func test_rootViewController_isTabBarWithThreeTabs() {
		let sut = makeSUT()

		_ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
		let root = sut.window?.rootViewController
		let tabBar = root as? UITabBarController

		XCTAssertNotNil(tabBar, "Expected rootViewController to be a `UITabBarController`")
		XCTAssertEqual(tabBar?.viewControllers?.count, 3, "Expected three tabs in the root `UITabBarController`")
	}

	func test_firstTab_isMVCFeedViewController() {
		let sut = makeSUT()
		_ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

		let tab = sut.tab(at: 0)

		XCTAssertEqual(tab.title, "MVC", "Expected first tab title to be `MVC`")
		XCTAssertTrue(tab.view is MVC.FeedViewController, "Expected first tab to be a `MVC.FeedViewController`, got \(String(describing: tab.view)) instead")
	}

	func test_secondTab_isMVVMFeedViewController() {
		let sut = makeSUT()
		_ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

		let tab = sut.tab(at: 1)

		XCTAssertEqual(tab.title, "MVVM", "Expected first tab title to be `MVVM`")
		XCTAssertTrue(tab.view is MVVM.FeedViewController, "Expected first tab to be a `MVVM.FeedViewController`, got \(String(describing: tab.view)) instead")
	}

	func test_thirdTab_isMVPFeedViewController() {
		let sut = makeSUT()
		_ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

		let tab = sut.tab(at: 2)

		XCTAssertEqual(tab.title, "MVP", "Expected first tab title to be `MVP`")
		XCTAssertTrue(tab.view is MVP.FeedViewController, "Expected first tab to be a `MVP.FeedViewController`, got \(String(describing: tab.view)) instead")
	}

	// MARK: - Helpers

	func makeSUT() -> AppDelegate {
		return AppDelegate()
	}
}

private extension AppDelegate {
	func tab(at index: Int) -> (title: String, view: UIViewController) {
		let root = window?.rootViewController
		let tabBar = root as? UITabBarController
		let tab = tabBar?.viewControllers?[index] as! UINavigationController
		return (tab.tabBarItem.title!, tab.topViewController!)
	}
}
