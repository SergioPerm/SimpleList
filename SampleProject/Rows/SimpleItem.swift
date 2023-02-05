//
//  SimpleItem.swift
//  SampleProject
//
//  Created by Sergio Lechini on 05.02.2023.
//

import SwiftUI


struct SimpleItem: View {
	let item: Item

	@State private var dragOffset: CGFloat = .zero
	@Binding var swipedItemId: String

	private let dragPadding: CGFloat = 50

	var body: some View {
		HStack(alignment: .center, spacing: 0) {
			Text(item.title)
				.padding(.leading, 16)
			Spacer()
			deleteButton
		}
		.frame(height: 44)
		.background(
			RoundedRectangle(cornerRadius: 12)
				.stroke(lineWidth: 3).foregroundColor(.blue)
				.padding(.trailing, dragPadding)
		).padding(3)
		.contentShape(Rectangle())
		.transition(.move(edge: .leading))
		.padding(.trailing, -dragPadding)
		.offset(x: dragOffset)
		.highPriorityGesture(
			swipeGesture
		)
		.onChange(of: swipedItemId, perform: { swipedId in
			guard swipedId != item.id.uuidString else { return }
			animateSwipe(0)
		})
	}

	var swipeGesture: some Gesture {
		DragGesture()
			.onChanged {
				guard abs($0.translation.width) > 20 else { return }

				let dragPadding = dragPadding
				let swipeRange: ClosedRange<CGFloat> = -(dragPadding)...0
				guard swipeRange.contains(dragOffset) else { return }
				var newOffset: CGFloat = $0.translation.width
				if newOffset < -dragPadding {
					newOffset = -dragPadding
				} else if newOffset > 0 && dragOffset >= 0 {
					newOffset = 0
				}
				
				if newOffset > 0 {
					newOffset += dragOffset
					newOffset = newOffset > 0 ? 0 : newOffset
				}
				
				animateSwipe(newOffset)
			}
			.onEnded { _ in
				let dragPadding = -dragPadding
				let openRange: ClosedRange<CGFloat> = dragPadding...(dragPadding / 2)
				if openRange.contains(dragOffset) {
					animateSwipe(dragPadding)
				} else {
					animateSwipe(0)
				}
			}
	}

	func animateSwipe(_ offset: CGFloat) {
		if offset == -dragPadding {
			swipedItemId = item.id.uuidString
		}

		withAnimation {
			dragOffset = offset
		}
	}

	var deleteButton: some View {
		Button {
			withAnimation {
				item.deleteAct()
			}
		} label: {
			VStack(alignment: .center, spacing: 0) {
				HStack(alignment: .center, spacing: 0) {
					Image(systemName: "trash")
						.resizable()
						.frame(width: 28, height: 28)
						.foregroundColor(.red)
				}
			}
		}
		.frame(width: 50)
	}
}
