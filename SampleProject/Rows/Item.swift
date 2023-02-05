//
//  Item.swift
//  SampleProject
//
//  Created by Sergio Lechini on 05.02.2023.
//

import Foundation

protocol ItemOutput: AnyObject {
	func onDelete(id: String)
}

final class Item: Identifiable {
	weak var output: ItemOutput?
	let id = UUID()

	let title: String

	init(title: String) {
		self.title = title
	}

	func deleteAct() {
		output?.onDelete(id: id.uuidString)
	}
}
