//
//  Marley_SpoonUITests.swift
//  Marley SpoonUITests
//
//  Created by Majid Khoshpour on 9/5/21.
//

import XCTest
@testable import Marley_Spoon

class MarleySpoonUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

        app.launchArguments.append("--uitesting")
    }

    func testShowSingleRecipe() {

        app.launch()

        _ = app.wait(for: .runningForeground, timeout: 5.0)

        _ = app.wait(for: .unknown, timeout: 5.0)

        // Make sure we're displaying tableview cells
        XCTAssertTrue(app.isDisplayingRexipeList)

        app.tables["mainTable"].cells.element(boundBy: 0).tap()

        _ = app.wait(for: .unknown, timeout: 1.0)

        XCTAssertTrue(app.isDisplayingTitle)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    var isDisplayingRexipeList: Bool {
        return tables["mainTable"].children(matching: .cell).count > 0
    }

    var isDisplayingTitle: Bool {
        return staticTexts["titleLabel"].label.count > 0
    }

}
