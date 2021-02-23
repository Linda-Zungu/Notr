//
//  ContentView.swift
//  Notr
//
//  Created by Linda Zungu on 2/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = "Start Note..."
    init(){
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().contentInset = .init(top: 120, left: 0, bottom: 350, right: 0)
    }
    @State private var scrollContentOffset : CGFloat = -300
    @State private var buttonExpanded = false
    @State private var headerHeightIncreased = false
    @State private var isModal = false
    @State private var isEditing = false
    @State private var offset = CGSize.zero
    @State private var selectedButtonIndex = 0
    
    var notesList = Notes()
    
    var body: some View {
        ZStack{
            TrackableScrollView(.vertical, showIndicators: true, contentOffset: $scrollContentOffset){
//                Text("\(self.scrollContentOffset)")
//                            .padding(.top, 80)
                Spacer(minLength: 50)
                
//                ForEach(0..<29){ i in
                ForEach(0..<notesList.notes.count, id: \.self) { i in
                    Button(action: {
                        self.isModal = true
                        self.isEditing = true
                        self.text = notesList.notes[i].noteText
                        self.selectedButtonIndex = i
                    }, label: {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .frame(width: 350, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    //                        .foregroundColor(.clear)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    //                        .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.7), Color.init(red: 0.6, green: 0.0, blue: 0.1).opacity(0.85)]), startPoint: .top, endPoint: .bottom)
    //                        )
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
                            .cornerRadius(25)
                            .shadow(color: .gray /*Color.red.opacity(0.7)*/,radius: 15, x: 0, y: 10)
                            .padding()
                    })
                }
                .padding(.top)
                
//                TextField("Search Notr...", text: .constant("placeholder"))
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                    .padding(.bottom, 45)

            }
//            .padding(.top, 50)
//            .ignoresSafeArea(/*@START_MENU_TOKEN@*/.keyboard/*@END_MENU_TOKEN@*/, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
//            .edgesIgnoringSafeArea(.top)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isModal = true
                    }, label: {
                        BlurView(style: .systemUltraThinMaterial)
                            .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(35)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                            .padding()
                            .offset(x: -4, y: 0)
                            .overlay(
                                Image(systemName: "plus")
                                    .offset(x: -4, y: 0)
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            )
                            
                    })
                    .animation(.spring(response: 0.3, dampingFraction: 0.63, blendDuration: 0.3))
                }
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            VStack{
                header
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            
            
            BlurView(style: .systemUltraThinMaterial)
                .overlay(
                    ZStack{
                        TextEditor(text: $text)
                            .padding(.leading, 20)
                            .foregroundColor(self.text == "Start Note..." ? .gray : .primary)
                            .onAppear {
                                // remove the placeholder text when keyboard appears
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                    withAnimation {
                                        if self.text == "Start Note..." {
                                            self.text = ""
                                        }
                                    }
                                }
                                
                                // put back the placeholder text if the user dismisses the keyboard without adding any text
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                    withAnimation {
                                        if self.text == "" {
                                            self.text = "Start Note..."
                                        }
                                    }
                                }
                            }

                        VStack{
                            sheetDragArea
                            Spacer()
                        }
                    }
                )
                .cornerRadius(47.33) //fix this for devices with rectangular screens.
                .offset(x: 0, y: isModal ? 0 : UIScreen.main.bounds.height)
                .offset(x: 0, y: isSheetDraggedUp() ? 0 : offset.height)
                .animation(.spring())
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .shadow(radius: 30)
                
                
        }
    }
    
    //MARK: SubViews
    private var header : some View{
        BlurView(style: .systemUltraThinMaterial)
            .frame(width: UIScreen.main.bounds.width, height: checkHeaderHeight(contentOffset: scrollContentOffset))
            .shadow(radius: 5)
            .overlay(
                HStack{
                    VStack{
                        HStack{
//                            Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "Notes" : "")
                            Text("Note")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .padding(.top, 40)
                                .padding(.horizontal)
                                .animation(.easeInOut(duration: 0.25))
                                .opacity((-Double(scrollContentOffset)+30)/(30))
                            
                            Spacer()
                            
                            Button(action: {}, label: {
//                                Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "Remove" : "")
                                Text("Remove")
                                    .padding(.top, 40)
                                    .padding(.horizontal)
                                    .animation(.easeInOut(duration: 0.25))
                                    .opacity((-Double(scrollContentOffset)+30)/(30))
                            })
                        }
                        
                        HStack{
//                            Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "\(getDate())" : "")
                            Text("\(getDate())")
                                .bold()
                                .foregroundColor(.gray)
                                .padding(.bottom)
                                .padding(.horizontal)
                                .animation(.easeInOut(duration: 0.25))
                                .opacity((-Double(scrollContentOffset)+30)/(30))
                                
                            Spacer()
                        }
                    }
                }
            )
            .animation(.easeInOut(duration: 0))
    }
    
    private var sheetDragArea : some View {
        BlurView(style: .systemUltraThinMaterial)
            .saturation(2.0)
            .frame(width: UIScreen.main.bounds.width, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }
                    .onEnded { _ in
                        if(self.offset.height > 100) {
                            offset.height = .zero
                            isModal = false
                        }
                        else{
                            self.offset.height = .zero
                        }
                    }
            )
            .shadow(radius: 1)
            .overlay(
                ZStack{
                    Image(systemName: "chevron.compact.down")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                        .padding(.top)
                    
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            editingNotesList()
                            notesList.notes.sort{
                                $0.noteDate > $1.noteDate
                            }
//                            offset.height = .zero
                            isModal = false
                            text = "Start Note..."
                            self.isEditing = false
                        }, label: {
                            Text("Done")
                                .bold()
                                .padding()
                                .padding(.top, 10)
                        })
                    }
                }
            )
    }
    
    
    //MARK: Functions
    private func isScrollPositionChanged(contentOffset:CGFloat) -> Bool{
        if(contentOffset == 0){
            return true
        }
        else if(contentOffset > 30){
            return false
        }
        else{
            return true
        }
    }
    
    private func checkHeaderHeight(contentOffset : CGFloat) -> CGFloat{
        if(contentOffset == 0){
            return 109
        }
        else if(contentOffset > 0){
            if(contentOffset >= 60){
                return 49
            }
            else{
                return -contentOffset+109
            }
            
        }
        else if(contentOffset < 0){
            return -contentOffset+109
        }
        else{
            return 0
        }
    }
    
    private func getDate() -> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: Date())
    }
    
    private func isSheetDraggedUp() -> Bool {
        if(self.offset.height < 0){
            return true
        }
        else{
            return false
        }
    }
    
    private func editingNotesList(){
        if(notesList.notes.isEmpty && text != ""){
            addNote(textNote: text)
        }
        else{
            if(text != "" && text != notesList.notes[selectedButtonIndex].noteText && isEditing == true){
                notesList.notes.remove(at: self.selectedButtonIndex)
                addNote(textNote: text)
            }
            else{
                if(text != "" && text != notesList.notes[selectedButtonIndex].noteText){
                    addNote(textNote: text)
                }
            }
        }
    }
    
    private func addNote(textNote: String){
        notesList.notes.append(Note(text: textNote, date: "date"))
        notesList.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
