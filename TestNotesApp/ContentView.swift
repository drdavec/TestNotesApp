//
//  ContentView.swift
//  TestNotesApp
//
//  Created by David Carlson on 8/22/23.
//

//import TestNote
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
	@Query private var notes: [Note]

    var body: some View {
        NavigationSplitView {
            List {
				Section("Items") {
					ForEach(items) { item in
						NavigationLink {
							Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
						} label: {
							Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
						}
					}
					.onDelete(perform: deleteItems)
				}
				
				Section("Notes") {
					ForEach(notes) { note in
						NavigationLink {
							Text("Note at \(note.createdDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
						} label: {
							VStack {
								Text(note.createdDate, format: Date.FormatStyle(date: .numeric, time: .standard))
								Text(note.content ?? "No content")
							}
						}
					}
					.onDelete(perform: deleteNotes)
				}
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
				ToolbarItem {
					Button(action: addNote) {
						Label("Add Item", systemImage: "square.and.pencil")
					}
				}
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
	
	private func addNote() {
		withAnimation {
			let newNote = Note(title: "My Title", content: "Add your note here.")
			modelContext.insert(newNote)
		}
	}

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
	
	private func deleteNotes(offsets: IndexSet) {
	 withAnimation {
		 for index in offsets {
			 modelContext.delete(notes[index])
		 }
	 }
 }
}

#Preview {
    ContentView()
		.modelContainer(for: [Item.self, Note.self], inMemory: true)
}
