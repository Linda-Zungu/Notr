//
//  NoteCardView.swift
//  Notr
//
//  Created by Linda Zungu on 2/25/21.
//

import SwiftUI

struct NoteCardView: View {
    
    var notesList : Notes
    var i : Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .frame(width: 350, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .overlay(
                VStack{
                    HStack{
                        Text("\(notesList.notes[i].noteDate)")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .shadow(radius: 1)
                            .padding()
                        
                        Spacer()
                            
                    }
                    HStack{
                        Text("\(notesList.notes[i].noteText)")
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    Spacer()
                }
                
            )
            .animation(.spring())
            .cornerRadius(25)
            .shadow(color: .gray /*Color.red.opacity(0.7)*/,radius: 15, x: 0, y: 10)
            .padding()
    }
}

struct NoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCardView(notesList: Notes(), i: 0).previewLayout(.sizeThatFits)
    }
}
