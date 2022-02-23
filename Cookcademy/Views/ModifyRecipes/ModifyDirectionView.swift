//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Roman on 24.01.2022.
//

import SwiftUI
 
struct ModifyDirectionView: ModifyComponentView {
  @Binding var direction: Direction
  let createAction: (Direction) -> Void
  
  init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
      self._direction = component
      self.createAction = createAction
    }
 
  private let listBackgroundColor = AppColor.background
  private let listTextColor = AppColor.foreground
 
  @Environment(\.presentationMode) private var mode
 
  var body: some View {
    Form {
      TextField("Direction Description", text: $direction.description)
        .listRowBackground(listBackgroundColor)
      Toggle("Optional", isOn: $direction.isOptional)
        .listRowBackground(listBackgroundColor)
      HStack {
        Spacer()
        Button("Save") {
          createAction(direction)
          mode.wrappedValue.dismiss()
        }
        Spacer()
      }.listRowBackground(listBackgroundColor)
    }
    .foregroundColor(listTextColor)
  }
}
 
struct ModifyDirectionView_Previews: PreviewProvider {
  @State static var emptyDirection = Direction(description: "", isOptional: false)
  static var previews: some View {
    NavigationView {
      ModifyDirectionView(component: $emptyDirection) { _ in return }
    }
  }
}
