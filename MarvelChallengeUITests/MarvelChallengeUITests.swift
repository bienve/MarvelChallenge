//
//  MarvelChallengeUITests.swift
//  MarvelChallengeUITests
//
//  Created by 67881458 on 7/11/22.
//

import XCTest

final class MarvelChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFirstCharacterSelection() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"3-D Man").children(matching: .other).element.children(matching: .other).element(boundBy: 2).tap()
        
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.otherElements.containing(.staticText, identifier:"3-D Man").element
        
        XCTAssertTrue(element.exists)
        
        let tabBar = app.tabBars["Tab Bar"]
        
        XCTAssertTrue(tabBar.exists)
        
        tabBar.buttons["Comics"].tap()
        
        let alert = app.alerts["Not implemented"]
        let okButton = alert.scrollViews.otherElements.buttons["Ok"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(okButton.exists)
        
        okButton.tap()
        
        app.navigationBars["MarvelChallenge.CharacterDetailView"].buttons["Marvel Characters"].tap()
        
        let aBombHasStaticText = XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.staticTexts["A-Bomb (HAS)"]/*[[".cells.staticTexts[\"A-Bomb (HAS)\"]",".staticTexts[\"A-Bomb (HAS)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(aBombHasStaticText.exists)
        
    
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
