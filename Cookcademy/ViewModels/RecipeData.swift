//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Ben Stone on 4/19/21.
//

import Foundation

class RecipeData: ObservableObject {
  @Published var recipes = Recipe.testRecipes

  func saveRecipes() {
    do {
      let encodedData = try JSONEncoder().encode(recipes)
      try encodedData.write(to: recipesFileURL)
    } catch {
      fatalError("An error occurred while saving recipes: \(error)")
    }
  }

  func loadRecipes() {
    guard let data = try? Data(contentsOf: recipesFileURL) else { return }
    do {
      let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
      recipes = savedRecipes
    } catch {
      fatalError("An error occurred while loading recipes: \(error)")
    }
  }

  private var recipesFileURL: URL {
    do {
      let documentsDirectory = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
      )
      return documentsDirectory.appendingPathComponent("recipeData")
    } catch {
      fatalError("An error occurred while getting the url: \(error)")
    }
  }

  var favoriteRecipes: [Recipe] {
    recipes.filter { $0.isFavorite }
  }

  func recipes(for category: MainInformation.Category) -> [Recipe] {
    var filteredRecipes: [Recipe] = []
    for recipe in recipes where recipe.mainInformation.category == category {
      filteredRecipes.append(recipe)
    }
    return filteredRecipes
  }

  func add(recipe: Recipe) {
    if recipe.isValid {
      recipes.append(recipe)
      saveRecipes()
    }
  }

  func index(of recipe: Recipe) -> Int? {
    for oneIndex in recipes.indices where recipes[oneIndex].id == recipe.id {
      return oneIndex
    }
    return nil
  }
}
