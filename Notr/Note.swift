//
//  Note.swift
//  Notr
//
//  Created by Linda Zungu on 2/22/21.
//

import Foundation

class Note: Identifiable, Codable{
    var id = UUID()
    let noteText : String
    
    init(text: String){
        self.noteText = text
    }
}

class Notes : ObservableObject{
    @Published var notes : [Note]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([Note].self, from: data) {
                self.notes = decoded
                return
            }
        }

        self.notes = []
    }
    
    func save(){
        if let encoded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }
}
