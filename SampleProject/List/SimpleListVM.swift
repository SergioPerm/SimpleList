//
//  SimpleListVM.swift
//  SampleProject
//
//  Created by Sergio Lechini on 05.02.2023.
//

import SwiftUI

final class SimpleListVM: ObservableObject {
	@Published var items: [Item] = []

	init() {
		fillItems()
	}
}

private extension SimpleListVM {
	func fillItems() {
		items.append(.init(title: "Item 1"))
		items.append(.init(title: "Item 2"))
		items.append(.init(title: "Item 3"))
		items.append(.init(title: "Item 4"))
		items.append(.init(title: "Item 5"))
		items.append(.init(title: "Item 6"))
		items.append(.init(title: "Item 7"))
		items.append(.init(title: "Item 8"))
		items.append(.init(title: "Item 9"))
		items.append(.init(title: "Item 10"))
		items.append(.init(title: "Item 11"))
		items.append(.init(title: "Item 12"))
		items.append(.init(title: "Item 13"))
		items.append(.init(title: "Item 14"))
		items.append(.init(title: "Item 15"))
		items.append(.init(title: "Item 16"))
		items.append(.init(title: "Item 17"))
		items.append(.init(title: "Item 18"))
		items.append(.init(title: "Item 19"))
		items.append(.init(title: "Item 20"))
		items.append(.init(title: "Item 21"))
		items.append(.init(title: "Item 22"))

		items.forEach { $0.output = self }
	}
}

extension SimpleListVM: ItemOutput {
	func onDelete(id: String) {
		guard let index = items.firstIndex(where: { $0.id.uuidString == id }) else { return }
		items.remove(at: index)
	}
}
