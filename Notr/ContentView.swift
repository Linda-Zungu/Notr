//
//  ContentView.swift
//  Notr
//
//  Created by Linda Zungu on 2/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    init(){
        UITextView.appearance().backgroundColor = .clear
    }
    @State private var scrollContentOffset : CGFloat = -300
    @State private var buttonExpanded = false
    @State private var headerHeightIncreased = false
    @State private var isModal = false
    
    var body: some View {
        ZStack{
            
            TrackableScrollView(.vertical, showIndicators: true, contentOffset: $scrollContentOffset){
//                Text("\(self.scrollContentOffset)")
//                            .padding(.top, 80)
                Spacer(minLength: 50)
                
//                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
//                    TextField("Search Notr...", text: $text)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                        .padding(.top)
//                        .padding(.bottom, -10)
                    
//                    Spacer()
//                }
                
                
                ForEach(0..<13){ i in
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .frame(width: 350, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.7), Color.init(red: 0.6, green: 0.0, blue: 0.1).opacity(0.85)]), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(25)
                        .shadow(color: Color.red.opacity(0.7),radius: 15, x: 0, y: 10)
                        .padding()
                }
                .padding(.top)
                
                TextField("Search Notr...", text: .constant("placeholder"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .padding(.bottom, 45)

            }
//            .padding(.top, 50)
//            .ignoresSafeArea(/*@START_MENU_TOKEN@*/.keyboard/*@END_MENU_TOKEN@*/, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
//            .edgesIgnoringSafeArea(.top)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
//                        buttonExpanded.toggle()
                        isModal = true
                    }, label: {
                        BlurView(style: .systemUltraThinMaterial)
//                            .frame(width: buttonExpanded ? UIScreen.main.bounds.width-22 : 70, height: buttonExpanded ? UIScreen.main.bounds.height-150 :  70, alignment: .center)
                            .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(35)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                            .padding()
                            .offset(x: -4, y: 0)
                            
                    })
                    .animation(.spring(response: 0.3, dampingFraction: 0.63, blendDuration: 0.3))
                }
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            
            VStack{
                header
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            
            BlurView(style: .systemUltraThinMaterial)
                .cornerRadius(45) //fix this for devices with rectangular screens.
                .overlay(
                    ZStack{
                        TextEditor(text: $text)
                            .padding(.leading, 20)
                            .padding(.top, 90)
//                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)

                        VStack{
                            BlurView(style: .systemUltraThinMaterial)
//                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                                .foregroundColor(.clear)
                                .frame(width: UIScreen.main.bounds.width, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    Image(systemName: "chevron.compact.down")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                        .padding(.top)
                                )
                                Spacer()
                        }
                        
                        
                        
//                        Divider()
                            
//
//
//                        Spacer()
                        
//                        RoundedRectangle(cornerRadius: 20)
//                            .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                )
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .offset(x: 0, y: isModal ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
                
        }
    }
    
    //MARK: SubViews
    private var header : some View{
        //MARK: The Header
        BlurView(style: .systemUltraThinMaterial)
            .frame(width: UIScreen.main.bounds.width, height: checkHeaderHeight(contentOffset: scrollContentOffset))
            .overlay(
                HStack{
                    VStack{
                        HStack{
                            Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "Notes" : "")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .padding(.top, 40)
                                .padding(.horizontal)
                                .animation(.easeInOut(duration: 0.25))
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "Remove" : "")
                                    .padding(.top, 40)
                                    .padding(.horizontal)
                                    .animation(.easeInOut(duration: 0.25))
                            })
                        }
                        
                        HStack{
                            Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "\(getDate())" : "")
                                .bold()
                                .foregroundColor(.gray)
                                .padding(.bottom)
                                .padding(.horizontal)
                                .animation(.easeInOut(duration: 0.25))
                                
                            
                            Spacer()
                        }
                    }
                }
            )
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .animation(.easeInOut(duration: 0))
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
