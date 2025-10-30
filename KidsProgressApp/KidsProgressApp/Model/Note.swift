//
//  Note.swift
//  KidsProgressApp
//
//  Created by Abdulmohammad BAIG on 2025-10-30.
//

import Foundation
import FirebaseDatabase

struct Note: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
}
