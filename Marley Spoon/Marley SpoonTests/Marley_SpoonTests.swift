//
//  Marley_SpoonTests.swift
//  Marley SpoonTests
//
//  Created by Majid Khoshpour on 9/5/21.
//

import XCTest
@testable import Marley_Spoon

class MarleySpoonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecipeListFetch() throws {
        let listViewModel = RecipeListViewModel()
        listViewModel.getRecipes()
        let expectation = XCTestExpectation(description: "Async get recipes")
        listViewModel.recipesLoaded = { [weak self] resipes in
            guard let _ = self else { return }
            expectation.fulfill()
            XCTAssertGreaterThan(resipes.count, 0)
        }
        wait(for: [expectation], timeout: 5)
    }

    func testSingleRecipeFetch(_ id: String = "4dT8tcb6ukGSIg2YyuGEOm") throws {
        let detailViewModel = RecipeDetailViewModel()

        // here we create a mock object with a specific id, we can assume that this id is always available in our moch server
        let recipe = Recipe(id: id)
        detailViewModel.recipe = recipe

        detailViewModel.getRecipe()
        let expectation = XCTestExpectation(description: "Async get recipe")
        detailViewModel.recipeLoaded = { [weak self] resipe in
            guard let _ = self else { return }
            expectation.fulfill()
            // test if this recipe has title (we assume that all recipes have titles)
            XCTAssertGreaterThan(resipe.title?.count ?? 0, 0)
        }
        wait(for: [expectation], timeout: 5)
    }


}
