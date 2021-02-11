//
//  ContentView.swift
//  Shared
//
//  Created by Roderic Campbell on 2/10/21.
//

import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices

public struct ItemWithChildren: Decodable, Identifiable, Equatable {
    public let id: UUID
    public let title: String
    public let children: [ItemWithChildren]?
    
    static let tree: [ItemWithChildren] = [
        .init(id: UUID(), title: "Some Top Level Thing",
              children: [
                .init(id: UUID(), title: "badfadf", children: nil),
                .init(id: UUID(), title: "cdasfadsf", children: nil)
              ]),
        .init(id: UUID(), title: "Another top level thing", children: nil),
        .init(id: UUID(), title: "More Things", children: nil)
    ]
    
}

struct ContentView: View {
    var body: some View {
        List (ItemWithChildren.tree) { item in
            Label(item.title, systemImage: "rectangle.3.offgrid.fill")
                .padding()
                .background(Color.secondary)
                .onDrag { NSItemProvider(object: item.id.uuidString as NSString) }
                .onDrop(of: [.text], isTargeted: nil, perform: { providers -> Bool in
                    print(providers)
                    return true
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
