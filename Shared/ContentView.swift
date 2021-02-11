//
//  ContentView.swift
//  Shared
//
//  Created by Roderic Campbell on 2/10/21.
//

import SwiftUI

public struct ItemWithChildren: Decodable, Identifiable, Equatable {
    public let id: UUID
    public let title: String
    public let children: [ItemWithChildren]?
    
    static let tree: [ItemWithChildren] = [
        .init(id: UUID(), title: "a",
              children: [
                .init(id: UUID(), title: "b", children: nil),
                .init(id: UUID(), title: "c", children: nil)
              ]),
        .init(id: UUID(), title: "b", children: nil),
        .init(id: UUID(), title: "c", children: nil)
    ]
    
}

struct ContentView: View {
    var body: some View {
        List {
            OutlineGroup (ItemWithChildren.tree, children: \.children) { item in
                Text(item.title)
                    .onDrag { NSItemProvider(object: item.id.uuidString as NSString) }
                    .onDrop(
                        of: ["public.text"],
                        delegate: StringDropDelegate()
                    )
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct StringDropDelegate: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        print(info)
        return true
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
