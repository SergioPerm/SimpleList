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

	var body: some View {
		HStack(alignment: .center, spacing: 0) {
			Text(item.title)
				.padding(.leading, 16)
			Spacer()
			deleteButton
		}
		.modifier(Style.Item())
		.offset(x: dragOffset)
		.gesture(
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

				let swipeRange: ClosedRange<CGFloat> = -(Style.dragPadding)...0
				guard swipeRange.contains(-Style.dragPadding) else { return }
				var newOffset: CGFloat = $0.translation.width
				if newOffset < -Style.dragPadding {
					newOffset = -Style.dragPadding
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
				let dragPadding = -Style.dragPadding
				let openRange: ClosedRange<CGFloat> = dragPadding...(dragPadding / 2)
				if openRange.contains(dragOffset) {
					animateSwipe(dragPadding)
				} else {
					animateSwipe(0)
				}
			}
	}

	func animateSwipe(_ offset: CGFloat) {
		if offset == -Style.dragPadding {
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
			Image(systemName: "trash")
				.resizable()
				.frame(width: 28, height: 28, alignment: .center)
				.foregroundColor(.red)
		}
		.frame(width: 50)
	}
}
