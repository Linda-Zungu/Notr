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
    let noteDate : String
    
    init(text: String, date: String){
        self.noteText = text
        self.noteDate = "\(Notes().getDate())"
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
    
    func getDate() -> String{
        let date = DateFormatter()
        
        date.dateStyle = .medium
        date.timeStyle = .short
        date.locale = Locale.current
        
        return date.string(from: Date())
    }
}
