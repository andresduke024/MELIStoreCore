//
//  RouterTests.swift
//  MELIStoreCore
//
//  Created by Andres Duque on 9/04/25.
//

import XCTest
@testable import MELIStoreCore

final class RouterTests: XCTestCase {
    
    private var sut: Router!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    enum MockRouteProtocol: RouteProtocol {
        case anyRoute
        case anyRoute2
    }
    
    func testPush() {
        sut = Router()
        
        sut.push(MockRouteProtocol.anyRoute)
        
        XCTAssertEqual(sut.navPath.count, 1)
    }
    
    func testPushDestination() {
        sut = Router()
        
        sut.push(destination: MockRouteProtocol.anyRoute)
        
        XCTAssertEqual(sut.navPath.count, 1)
    }
    
    func testPop() {
        sut = Router()
        
        sut.push(MockRouteProtocol.anyRoute)
        
        sut.pop()
        
        XCTAssertEqual(sut.navPath.count, 0)
    }
    
    func testPopToRoot() {
        sut = Router()
        
        sut.push(MockRouteProtocol.anyRoute)
        sut.push(MockRouteProtocol.anyRoute2)
        
        sut.popToRoot()
        
        XCTAssertEqual(sut.navPath.count, 0)
    }
    
    func testReplace() {
        sut = Router()
        
        sut.replace(newDestination: MockRouteProtocol.anyRoute)
        
        XCTAssertEqual(sut.navPath.count, 1)
    }
}
