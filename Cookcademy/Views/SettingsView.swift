//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Roman on 10.04.2022.
//

import SwiftUI

struct SettingsView: View {
  @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
  @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
  @AppStorage("listTextColor") private var listTextColor = AppColor.foreground

  var body: some View {
    NavigationView {
      Form {
        ColorPicker("List BackgroundColor", selection: $listBackgroundColor)
          .padding()
          .listRowBackground(listBackgroundColor)
        ColorPicker("Text Color", selection: $listTextColor)
          .padding()
          .listRowBackground(listBackgroundColor)
        Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
          .padding()
          .listRowBackground(listBackgroundColor)
      }
      .foregroundColor(listTextColor)
      .navigationTitle("Settings")
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}