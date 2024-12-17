//
//  FluidShape.swift
//  FluidButton
//
//  Created by Kostiantyn Stoliarenko on 16.12.24.
//

import SwiftUI

// MARK: - FluidShape

struct FluidShape: Shape {

    // MARK: - Internal Properties

    var progress: CGFloat

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    // MARK: - Internal Methods

    func path(in rect: CGRect) -> Path {
        var path = Path()

        if progress == 0 {
            path.addRoundedRect(in: rect, cornerSize: CGSize(width: 10, height: 10))
            return path
        }

        let baseCornerRadius: CGFloat = 10
        let waveHeight = rect.height * 0.6 * progress
        let controlOffsetX = rect.width * 0.15 * progress

        let topLeftRadius = baseCornerRadius * (1 - progress)
        let topRightRadius = baseCornerRadius * (1 - progress)
        let bottomRightRadius = baseCornerRadius * (1 - progress)
        let bottomLeftRadius = baseCornerRadius * (1 - progress)

        // Top edge with dynamic waves
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.minY),
            control: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.minY - waveHeight)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.minY),
            control: CGPoint(x: rect.midX, y: rect.minY - waveHeight * 1.2)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY),
            control: CGPoint(x: rect.maxX - rect.width * 0.2, y: rect.minY - waveHeight)
        )

        // Right wave edge
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.2),
            control: CGPoint(x: rect.maxX + controlOffsetX, y: rect.minY + rect.height * 0.1)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.2),
            control: CGPoint(x: rect.maxX + controlOffsetX, y: rect.midY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY),
            control: CGPoint(x: rect.maxX + controlOffsetX, y: rect.maxY - rect.height * 0.1)
        )

        // Bottom edge with mirrored waves
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.maxY),
            control: CGPoint(x: rect.midX * 1.6, y: rect.maxY + waveHeight * 1.2)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.maxY),
            control: CGPoint(x: rect.midX, y: rect.maxY + waveHeight * 1.2)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY),
            control: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.maxY + waveHeight)
        )

        // Left wave edge
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY - rect.height * 0.2),
            control: CGPoint(x: rect.minX - controlOffsetX, y: rect.maxY - rect.height * 0.1)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.2),
            control: CGPoint(x: rect.minX - controlOffsetX, y: rect.midY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY),
            control: CGPoint(x: rect.minX - controlOffsetX, y: rect.minY + rect.height * 0.1)
        )

        path.closeSubpath()
        return path
    }
}
