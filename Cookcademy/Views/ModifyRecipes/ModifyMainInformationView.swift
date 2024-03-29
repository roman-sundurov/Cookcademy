//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Roman on 22.01.2022.
//

import SwiftUI

struct ModifyMainInformationView: View {
  @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
  @Binding var mainInformation: MainInformation
  private let listTextColor = AppColor.foreground

  var body: some View {
    Form {
      TextField("Recipe Name", text: $mainInformation.name)
        .listRowBackground(listBackgroundColor)
      TextField("Author", text: $mainInformation.author)
        .listRowBackground(listBackgroundColor)
      Section(header: Text("Description")) {
        TextEditor(text: $mainInformation.description)
          .listRowBackground(listBackgroundColor)
      }
      Picker(
        selection: $mainInformation.category,
        label: HStack {
          Text("Category")
          Spacer()
          Text(mainInformation.category.rawValue)
        }) {
          ForEach(
            MainInformation.Category.allCases, id: \.self) { category in
              Text(category.rawValue)
            }
        }
        .listRowBackground(listBackgroundColor)
        .pickerStyle(MenuPickerStyle())
    }
    .foregroundColor(listTextColor)
  }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
  @State static var mainInformation = MainInformation(
    name: "TestName",
    description: "TestDescription",
    author: "TestAutor",
    category: MainInformation.Category.lunch)
    static var previews: some View {
      ModifyMainInformationView(mainInformation: $mainInformation)
    }
}
