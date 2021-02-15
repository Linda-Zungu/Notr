//
//  ContentView.swift
//  Notr
//
//  Created by Linda Zungu on 2/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    @State private var scrollContentOffset:CGFloat = 0
    
    var body: some View {
        ZStack{
            
            TrackableScrollView(.vertical, showIndicators: true, contentOffset: $scrollContentOffset){
//                Text("\(self.scrollContentOffset)")
//                            .padding(.top, 80)
                HStack{
//                    Text("Notr")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
                    TextField("Search Notr...", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
//                    Spacer()
                }
                
                
                ForEach(0..<100){ i in
                    Spacer()
                    Text("Hello World").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                
                .padding()
                
                
                
            }
//            .padding(.top, 50)
//            .ignoresSafeArea(/*@START_MENU_TOKEN@*/.keyboard/*@END_MENU_TOKEN@*/, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
//            .edgesIgnoringSafeArea(.top)
            
            
            VStack{
                BlurView(style: .systemUltraThinMaterial)
                    .frame(width: UIScreen.main.bounds.width, height: isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? 0 : 109)
                    
                    .overlay(
                        HStack{
                            VStack{
                                HStack{
                                    Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "" :"Notes")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .bold()
                                        .padding(.top, 40)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text(isScrollPositionChanged(contentOffset: self.scrollContentOffset) ? "" : "15 February 2021")
                                        .bold()
                                        .foregroundColor(.gray)
                                        .padding(.bottom)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                            }
                        }
                    )
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .animation(.easeInOut(duration: 0.25))
                Spacer()
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    
    private func isScrollPositionChanged(contentOffset:CGFloat) -> Bool{
        if(contentOffset == 0){
            return true
        }
        else if(contentOffset > 0){
            return false
        }
        else{
            return true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
