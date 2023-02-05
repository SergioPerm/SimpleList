//
//  SimpleList.swift
//  SampleProject
//
//  Created by Sergio Lechini on 05.02.2023.
//

import SwiftUI

struct SimpleList: View {
	@StateObject var vm: SimpleListVM
	@State var swipeItemId: String = ""

	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 8) {
				ForEach(vm.items) { item in
					SimpleItem(item: item, swipedItemId: $swipeItemId)
				}
			}
		}
	}
}

struct SimpleList_Previews: PreviewProvider {
	static var previews: some View {
		SimpleList(vm: SimpleListVM())
	}
}
