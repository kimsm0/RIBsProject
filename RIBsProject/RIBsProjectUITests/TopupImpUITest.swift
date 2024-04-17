//
//  Topup.swift
//  RIBsProjectUITests
//
//  Created by kimsoomin_mac2022 on 4/17/24.
//

import XCTest
import Swifter

final class TopupImpUITest: XCTestCase {

    private var app: XCUIApplication!
    private var server: HttpServer!
    override func setUpWithError() throws {
        continueAfterFailure = false
        server = HttpServer()
        
        app = XCUIApplication()
        
    }


    func testTopupSuccess() throws { 
        
        let cardOnFileJSONPath = try TestUtil.path(for: "cardOnFile.json", in: type(of: self))
        server["/cards"] = shareFile(cardOnFileJSONPath)
        
        let topupJSONPath = try TestUtil.path(for: "topupSuccessResponse.json", in: type(of: self))
        server["/topup"] = shareFile(topupJSONPath)
        
        try server.start()
        
        app.launch()
        
        XCTAssertTrue(isDisplayed(app.staticTexts["슈퍼택시"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["슈퍼마트"]))
        
        app.tabBars.buttons["superpay_home_tab_bar_item"].tap()
        app.buttons["superpay_dashboard_charge_button"].tap()
        
        let tf = app.textFields["topup_enteramount_textField"]
        tf.tap()
        tf.typeText("10000")
                
    }
}
