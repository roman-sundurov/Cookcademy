//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Roman on 15.01.2022.
//

import SwiftUI
 
struct RecipeDetailView: View {
  @Binding var recipe: Recipe

  @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
  @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
  @EnvironmentObject private var recipeData: RecipeData
  @State private var isPresenting = false

  private let listTextColor = AppColor.foreground
 
  var body: some View {
    VStack {
      HStack {
        Text("Author: \(recipe.mainInformation.author)")
          .font(.subheadline)
          .padding()
        Spacer()
      }
      HStack {
        Text(recipe.mainInformation.description)
          .font(.subheadline)
          .padding()
        Spacer()
      }
//      Spacer()
      List {
        Section(header: Text("Ingredients")) {
          ForEach(recipe.ingredients.indices, id: \.self) { index in
            let ingredient = recipe.ingredients[index]
            Text(ingredient.description)
              .foregroundColor(listTextColor)
          }
        }
        .listRowBackground(listBackgroundColor)
        Section(header: Text("Directions")) {
          ForEach(recipe.directions.indices, id: \.self) { index in
            let direction = recipe.directions[index]
            if direction.isOptional && hideOptionalSteps {
              EmptyView()
            } else {
              HStack {
                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                Text("\(index + 1). ").bold()
                Text("\(direction.isOptional ? "(Optional) " : "")\(direction.description)")
              }
              .foregroundColor(listTextColor)
            }
          }
        }
        .listRowBackground(listBackgroundColor)
      }
    }
    .navigationTitle(recipe.mainInformation.name)
    .toolbar {
      ToolbarItem {
        HStack {
          Button("Edit") {
            isPresenting = true
          }
          Button(action: { recipe.isFavorite.toggle() }) {
            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
          }
        }
      }
      }
      .sheet(isPresented: $isPresenting) {
        NavigationView {
          ModifyRecipeView(recipe: $recipe)
          .toolbar {
            ToolbarItem(placement: .confirmationAction) {
              Button("Save") {
                isPresenting = false
              }
            }
          }
          .navigationTitle("Edit Recipe")
        }
        .onDisappear() {
          recipeData.saveRecipes()
        }
      }
  }
}
 
struct RecipeDetailView_Previews: PreviewProvider {
  @State static var recipe = Recipe.testRecipes[0]
  static var previews: some View {
    NavigationView {
      RecipeDetailView(recipe: $recipe)
    }
  }
}
