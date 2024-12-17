//
//  FluidButton.swift
//  FluidButton
//
//  Created by Kostiantyn Stoliarenko on 16.12.24.
//

import SwiftUI

// MARK: - FluidButton

struct FluidButton: View {

    // MARK: - Private Properties

    @State private var isPressed: Bool = false

    private var title: String
    private var titleColor: Color
    private var backgroundColor: Color
    private var pressedBackgroundColor: Color
    private var pressed: (() -> Void)?
    private var fullyPressed: (() -> Void)?

    // MARK: - Init

    init(
        title: String = "Fluid Button",
        titleColor: Color = .white,
        backgroundColor: Color = .buttonBackground,
        pressedBackgroundColor: Color = .buttonPressedBackground,
        pressed: (() -> Void)? = nil,
        fullyPressed: (() -> Void)? = nil
    ) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.pressedBackgroundColor = pressedBackgroundColor
        self.pressed = pressed
        self.fullyPressed = fullyPressed
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            FluidShape(progress: isPressed ? 1.0 : 0.0)
                .fill(isPressed ? pressedBackgroundColor : backgroundColor)
                .shadow(color: isPressed ? Color.black.opacity(0.5) : Color.clear, radius: 10, x: 0, y: 10)
                .animation(.easeInOut(duration: 0.5), value: isPressed)

            Text(title)
                .foregroundColor(titleColor)
                .font(.system(size: isPressed ? 24 : 18, weight: isPressed ? .light : .bold))
                .animation(.easeInOut(duration: 0.5), value: isPressed)
        }
        .onLongPressGesture(
            minimumDuration: 0.4,
            pressing: { pressing in
                withAnimation {
                    isPressed = pressing
                }
            },
            perform: {
                fullyPressed?()
            }
        )
        .onChange(of: isPressed) { oldValue, newValue in
            guard newValue else { return }
            pressed?()
        }
    }
}

// MARK: - Preview

#Preview {
    FluidButton()
        .frame(height: 50)
        .padding(.horizontal, 40)
}
