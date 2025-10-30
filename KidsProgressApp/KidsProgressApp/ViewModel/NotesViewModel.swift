//
//  NotesViewModel.swift
//  KidsProgressApp
//
//  Created by Abdulmohammad BAIG on 2025-10-30.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private var ref = Database.database().reference().child("notes")

    // MARK: - Create / Insert
    func addNote(title: String, description: String) {
        let id = UUID().uuidString
        let noteData = ["id": id, "title": title, "description": description]
        ref.child(id).setValue(noteData)
    }

    // MARK: - Read / Retrieve
    func fetchNotes() {
        ref.observe(.value) { snapshot in
            var fetched: [Note] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: String],
                   let title = dict["title"],
                   let desc = dict["description"] {
                    fetched.append(Note(id: snap.key, title: title, description: desc))
                }
            }
            DispatchQueue.main.async {
                self.notes = fetched
            }
        }
    }

    // MARK: - Update
    func updateNote(note: Note, newTitle: String, newDesc: String) {
        ref.child(note.id).updateChildValues(["title": newTitle, "description": newDesc])
    }

    // MARK: - Delete
    func deleteNote(note: Note) {
        ref.child(note.id).removeValue()
    }

    // MARK: - File Upload
    func uploadFile(imageData: Data, completion: @escaping (Double) -> Void) {
        let storageRef = Storage.storage().reference().child("uploads/\(UUID().uuidString).jpg")
        let uploadTask = storageRef.putData(imageData, metadata: nil)
        
        uploadTask.observe(.progress) { snapshot in
            if let progress = snapshot.progress {
                let percent = Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
                completion(percent)
            }
        }
    }
}
