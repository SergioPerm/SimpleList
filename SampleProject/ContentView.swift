//
//  ContentView.swift
//  SampleProject
//
//  Created by Sergio Lechini on 05.02.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			header
			list
		}.padding(.horizontal, 16)
    }
}

extension ContentView {
	var list: some View {
		VStack(alignment: .leading, spacing: 0) {
			SimpleList(vm: .init())
		}
	}

	var header: some View {
		HStack(alignment: .center, spacing: 0) {
			Text("Simple list")
				.foregroundColor(.black)
				.font(.system(size: 19, weight: .heavy))
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
