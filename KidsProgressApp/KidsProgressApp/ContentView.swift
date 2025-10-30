//
//  ContentView.swift
//  KidsProgressApp
//
//  Created by Abdulmohammad BAIG on 2025-10-30.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var vm = NotesViewModel()
    @State private var title = ""
    @State private var description = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var uploadProgress = 0.0

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    Button("Add Note") {
                        vm.addNote(title: title, description: description)
                        title = ""
                        description = ""
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Upload Image") {
                        showImagePicker = true
                    }
                    .buttonStyle(.bordered)
                }

                if uploadProgress > 0 {
                    ProgressView(value: uploadProgress)
                        .padding()
                }

                List {
                    ForEach(vm.notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title).bold()
                            Text(note.description).font(.subheadline)
                        }
                        .swipeActions {
                            Button("Delete") {
                                vm.deleteNote(note: note)
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("My Notes App")
            .onAppear {
                vm.fetchNotes()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage) { image in
                    if let data = image.jpegData(compressionQuality: 0.8) {
                        vm.uploadFile(imageData: data) { progress in
                            uploadProgress = progress
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
