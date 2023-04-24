//
//  RatingView.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-24.
//

import SwiftUI

struct RatingView: View {
    @Binding var progress : Double
    var color : Color = Color.green


    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 11.0)
                .opacity(0.60)
                .foregroundColor(Color.gray)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut, value: 2.0)

            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.white)
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(progress: .constant(0.8))
    }
}
