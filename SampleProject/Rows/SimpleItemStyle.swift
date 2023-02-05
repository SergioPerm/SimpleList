//
//  SimpleItemStyle.swift
//  SampleProject
//
//  Created by Sergio Lechini on 05.02.2023.
//

import SwiftUI

extension SimpleItem {
	struct Style {
		static let dragPadding: CGFloat = 50.0
	
		struct Item: ViewModifier {
			func body(content: Content) -> some View {
				content
					.frame(height: 44)
					.background(
						RoundedRectangle(cornerRadius: 12)
							.stroke(lineWidth: 3).foregroundColor(.blue)
							.padding(.trailing, Style.dragPadding)
					).padding(3)
					.contentShape(Rectangle())
					.transition(.move(edge: .leading))
					.padding(.trailing, -Style.dragPadding)
			}
		}
	}
}
