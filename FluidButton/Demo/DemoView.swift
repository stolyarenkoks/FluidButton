//
//  DemoView.swift
//  FluidButton
//
//  Created by Kostiantyn Stoliarenko on 17.12.24.
//

import SwiftUI

// MARK: - DemoView

struct DemoView: View {

    @State private var isLightEnabled: Bool = false
    @State private var isHintVisible: Bool = false

    private var mainImageResource: ImageResource {
        isLightEnabled ? .bulbOn : .bulbOff
    }

    private var hintTitle: String {
        "Long press Fluid Button to \(isLightEnabled ? "Disable" : "Enable")"
    }

    private var hintImageName: String {
        isLightEnabled ? "lightbulb" : "lightbulb.min"
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)

            VStack {
                Spacer()

                Image(mainImageResource)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .animation(.easeInOut(duration: 0.5), value: isLightEnabled)

                Spacer()

                FluidButton(
                    title: "Fluid Button",
                    titleColor: .white,
                    backgroundColor: .buttonBackground,
                    pressedBackgroundColor: .buttonPressedBackground,
                    pressed: {
                        print("Fluid Button Pressed")
                        isHintVisible = true
                    },
                    fullyPressed: {
                        isLightEnabled.toggle()
                        isHintVisible = false
                        print("Fluid Button Fully Pressed")
                    }
                )
                .frame(height: 50)

                Spacer()

                HStack {
                    Text(hintTitle)

                    Image(systemName: hintImageName)
                }
                .font(.subheadline)
                .opacity(isHintVisible ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.5), value: isHintVisible)

                Spacer()
            }
            .padding(.horizontal, 40)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview {
    DemoView()
}
