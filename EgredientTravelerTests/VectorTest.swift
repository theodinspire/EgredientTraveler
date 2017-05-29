//
//  VectorTest.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/27/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import XCTest
@testable import EgredientTraveler

class VectorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEquals_VectorsAreEqual() {
        let a = Vector(x: 1, y: 1, z: 1)
        let b = Vector(x: 1, y: 1, z: 1)
        
        XCTAssertEqual(a, b)
    }
    
    func testEquals_VectorsAreNotEqual() {
        let a = Vector(x: 1, y: 2, z: 3)
        let b = Vector(x: 3, y: 2, z: 1)
        
        XCTAssertNotEqual(a, b)
    }
    
    func testAddition_VectorsAdd() {
        let a = Vector(x: 1, y: 1, z: 1)
        let twiceA = Vector(x: 2, y: 2, z: 2)
        
        XCTAssertEqual(a + a, twiceA)
    }
    
    func testDot_OrthogonalVectorsMakeZero() {
        let a = Vector.i
        let b = Vector.j
        
        XCTAssertEqual(a.dot(b), 0)
    }
    
    func testDot_ParallelVectorsMakeMagnitude() {
        let a = Vector.i
        
        XCTAssertEqual(a.dot(a), a.magnitude)
    }
    
    func testCross_OrthogonalVectorsMakeThird() {
        XCTAssertEqual(Vector.i.cross(Vector.j), Vector.k)
    }
    
    func testCross_ParallelVectorsMakeZero() {
        let a = Vector.i
        
        XCTAssertEqual(a.cross(a), Vector.zeroVector)
    }
}
