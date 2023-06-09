//
//  MealGeneratorTests.swift
//  MealGeneratorTests
//
//  Created by Vinodh Sekhar on 5/20/23.
//

import XCTest
@testable import MealGenerator

final class MealGeneratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testGetDesserts(){
        
        var mealGenerator = MealGenerator()
        var desert_count = 64
        
        mealGenerator.getDesserts()
        
        var number_of_desserts = mealGenerator.listOfDesserts.count
        
        XCTAssertTrue(number_of_desserts == 64)
        
    
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
