# The UI Design Patterns Challenge - iOSLeadEssentials.com

![](https://github.com/essentialdevelopercom/ios-lead-essentials-ui-design-patterns-challenge/workflows/CI/badge.svg)

It’s time to put your UI design patterns skills to the test! 

You are called to implement a new UI feature: displaying localized error messages to the customers when the app fails to load the feed.

The goal is to implement this feature in both **MVVM** and **MVP**.

We’ve provided you with an MVC implementation using a reusable `ErrorView` as the `UITableView.tableHeaderView`. 

You can study and use the MVC solution as a guide to help you implement the same feature using MVVM and MVP.

![Feed iOS App UI](feed_ios_app_ui.png)


## Goals

1) Display an error message to the customer when the app fails to load the feed.

2) The error message must be localized in **at least** 4 languages. 

	- The challenge project comes with three supported languages: English, Portuguese, and Greek. 

	- The MVC solution contains the error message translated in the 3 given supported languages. You should reuse those messages in your MVVM and MVP solutions. 

	- You need to **add one extra language** of your choice to all 4 modules (MVC, MVVM, MVP, and the main `Feed iOS App` module)

		- Tip: use Google Translate if needed

	- When adding a new localization to the project, make sure to select all resource files for all 4 modules.

3) The customer should be able to tap to dismiss the error message.

5) Write tests to validate your implementation, including dismiss on tap (aim to write the test first!).


## Instructions

1) Fork the latest version of this repository. Here's <a href="https://guides.github.com/activities/forking" target="_blank">how forking works</a>.

2) Open the `UIDesignPatternsChallenge.xcodeproj` project on Xcode 12.4 (you can use other Xcode versions by switching to the appropriate branch, e.g., `xcode11`, `xcode12`, `xcode12_2`, `xcode12_3`).

	- Do not change the indentation in the project.

	- Do not rename the existing classes and files.

	- Important: Every time you build the project, it'll automatically reformat the modified files with SwiftFormat to maintain the code consistent.

3) The project is separated into modules:

	- The `Feed Feature Module` is the shared module containing the `FeedItem` data model and abstract interfaces. ***You won’t need to change anything in this module.***
	
	- The `Feed iOS App` is the Main iOS Application module for composing the MV\* solutions in a `UITabBarController` and running the iOS application. ***You won’t need to change anything in this module.***

	- The `MVC Module` contains the finished MVC solution—use it as a guideline.
	
	- The `MVVM Module` contains the unfinished MVVM solution. You must implement the localized error message.
	
	- The `MVP Module` contains the unfinished MVP solution. You must implement the localized error message.

4) Every module has its own scheme for building and running tests. 
	- When studying the MVC solution, switch to the MVC scheme. 
	- When developing the MVVM solution, switch to the MVVM scheme. 
	- When developing the MVP solution, switch to the MVP scheme.
	- When running the application, switch to the `Feed iOS App` scheme.

5) While developing your solutions, run all tests in the selected scheme with CMD+U.

6) The MV\* modules are independent of each other. For example, a change in the MVC `FeedViewController` will not affect the MVVM `FeedViewController` (even though they have the same name, they belong to distinct module namespaces!).

7) Your changes in the MV\* modules will reflect in the respective MV\* tab of the `Feed iOS App` Application.
	- If you’re interested in studying the composition of the MV\* modules, have a look at the `AppDelegate` in the `Feed iOS App` module.

8) You can see/interact with your solution by running the Application on the simulator (or device). 
	- Switch to the `Feed iOS App` scheme and press CMD+R.
	- Navigate to the MV\* tab on the simulator/device.
	- *The feed reload will always fail after a given timeout, so you can test your solution.* If you’re interested in studying how the feed reload always fails, have a look at the `AlwaysFailingLoader` (and its tests!) in the `Feed iOS App` module.

9) The layout should match the provided MVC solution and support Dark Mode.

10) The MVVM and MVP modules contain commented-out snapshot tests at `MV\* Module/Tests/Feed UI/FeedUISnapshotTests.swift`.
	
	- Uncomment and run one snapshot test at a time to validate the layout is pixel-perfect in Light and Dark Mode. 

	- ⚠️ Important: ***Different simulators may generate slightly different snapshots (even if they look the same!).*** So you must run the snapshot tests using the appropriate simulator based on the branch you chose:

		- `xcode11` -> iPhone 11 - iOS 13.x
		- `xcode12` -> iPhone 12 - iOS 14.0 or iOS 14.1
		- `xcode12_2` -> iPhone 12 - iOS 14.2
		- `xcode12_3` -> iPhone 12 - iOS 14.3
		- `xcode12_4` -> iPhone 12 - iOS 14.4

	- All snapshot tests must pass before you submit the pull request.

11) When all tests are passing and you're done implementing your solution:

	- Create a Pull Request from your branch to the main challenge repo's matching branch.

		- For example, if you implemented the challenge using the `xcode12_4` branch, your PR should be from your fork's `xcode12_4` branch into the main repo's `xcode12_4` branch (DO NOT MIX Xcode versions or you'll have merge conflicts!).

	- The title of the Pull Request should be: **Your Name - UI Design Patterns Challenge**.

12) Review your code in the Pull Request (PR) and make sure it follows **all** the instructions above. 

	- If it doesn't, make the appropriate changes, push, and review your code in the PR again.

13) After you review your code and it follows **all** the instructions above:
	
	- Post a comment in the challenge page in the academy with the link to your PR, so we can review your solution and provide feedback.


## Guidelines

1) Aim to commit your changes every time you add/alter the behavior of your system or refactor your code.

2) Aim for descriptive commit messages that clarify the intent of your contribution which will help other developers understand your train of thought and purpose of changes.

3) The system should always be in a green state, meaning that in each commit all tests should be passing.

4) The project should build without warnings.

5) The code should be carefully organized and easy to read (e.g. indentation must be consistent).

6) Make careful and proper use of access control, marking as `private` any implementation details that aren’t referenced from other external components.

7) Aim to write self-documenting code by providing context and detail when naming your components, avoiding explanations in comments.

Happy coding!
