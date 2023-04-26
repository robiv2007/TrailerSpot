//
//  RoundedRectangleModifier.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-26.
//

import Foundation
import SwiftUI

struct RoundedRectangleModifier: ViewModifier {
    let font = Font.system(size: 24).weight(.semibold)
    func body(content: Content) -> some View {
        content
            .font(font)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .background(.thinMaterial)
            .cornerRadius(50)
    }
}
