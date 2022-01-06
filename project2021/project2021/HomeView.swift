//
//  HomeView.swift
//  project2021
//
//  Created by Malin Lehander on 2021-12-20.
//


import SwiftUI

struct HomeView: View{
    @EnvironmentObject var viewModel: MeasurementViewModel
    @State var text = ""
    @State private var showPush = false
    @State private var showPull = false
    @State private var pressed = 0

    
    var body: some View{
        ZStack{
            VStack{
                Text("Push n Pull App")
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Spacer()
                Text("Choose push or pull: ")
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                HStack{
                    Button(action:{
                        self.pressed = 1
                        }, label: {HStack{
                            Text("Push").font(.headline).fontWeight(.bold).foregroundColor(.white).padding().padding(.horizontal,20).background(Color.green.cornerRadius(20).shadow(radius: 5))}})
                    Button(action:{
                        self.pressed = 2
                        }, label: {HStack{
                            Text("Pull").font(.headline).fontWeight(.bold).foregroundColor(.white).padding().padding(.horizontal,20).background(Color.green.cornerRadius(20).shadow(radius: 5))}})}
                Spacer()
                Text(text)
                Spacer()
                Button(action: {
                    viewModel.StartButtonPressed((Any).self)
                    if pressed == 1{
                        self.text=""
                        withAnimation(.linear(duration:0.2)){
                        showPush.toggle()
                        }}
                    else if pressed == 2{
                        self.text="Pull is not available"
                        //withAnimation(.linear(duration:0.2)){
                        //showPull.toggle()
                        //}
                        
                    }
                    else {
                        self.text = "Must choose push or pull!"
                    }
                    self.pressed = 0
                }, label:{HStack{
                    Image(systemName: "play.square")
                    Text("Start")
                }}).font(.largeTitle).foregroundColor(.white).padding().padding(.horizontal,25).background(Color.green.cornerRadius(20).shadow(radius: 4))
                Spacer()
                }
            PopUpPush(showPush: $showPush, showPull: $showPull)
            PopUpPull(showPush: $showPush, showPull: $showPull)
            
        }
    }
}

struct PopUpPush: View {
    @Binding var showPush: Bool
    @Binding var showPull: Bool
    @State private var showSaved = false
    @EnvironmentObject var viewModel: MeasurementViewModel

    var body: some View{
        ZStack{
            
            if showPush {
                VStack{
                    Text("PUSH")
                        .font(.title).fontWeight(.bold).foregroundColor(Color.blue).padding(.top)
                    Text("Measurement in progress...")
                        .font(.title).fontWeight(.bold).foregroundColor(Color.blue).padding(.top)
                    Spacer()

                    Button(action:{
                        viewModel.measurementDone()
                        viewModel.StopButtonPressed((Any).self)
                        withAnimation(.linear(duration:0.3)){
                            showSaved.toggle()
                    }
                    },label:{HStack{
                        Image(systemName: "square.and.arrow.down")
                        Text("Quit & Save")
                    }})
                    Spacer()
                }
                PopUpSaved(showPopUp: $showSaved, showPush: $showPush, showPull: $showPull)
            }
        }.frame(minWidth: 400).border(Color.white,width:2).background(Color.white)
    }
    
}
struct PopUpPull: View {
    @Binding var showPush: Bool
    @Binding var showPull: Bool
    @State private var showSaved = false
    
    @EnvironmentObject var viewModel: MeasurementViewModel
    var body: some View{
        ZStack{
            if showPull {
                VStack{
                    Text("PULL")
                        .font(.title).fontWeight(.bold).foregroundColor(Color.blue).padding(.top)
                    Text("Measurement in progress...")
                        .font(.title).fontWeight(.bold).foregroundColor(Color.blue).padding(.top)
                    Spacer()
                    Button(action:{
                        viewModel.measurementDone()
                        viewModel.StopButtonPressed((Any).self)
                        withAnimation(.linear(duration:0.3)){
                            showSaved.toggle()
                    }
                    },label:{HStack{
                        Image(systemName: "square.and.arrow.down")
                        Text("Quit & Save")
                    }})
                    Spacer()
                }
                PopUpSaved(showPopUp: $showSaved, showPush: $showPush, showPull: $showPull)
            }
        }.frame(minWidth: 400).border(Color.white,width:2).background(Color.white)
    }
    
}

struct PopUpSaved: View{
    @Binding var showPopUp: Bool
    @Binding var showPush: Bool
    @Binding var showPull: Bool
    var body: some View{
        ZStack{
            if showPopUp{
                VStack{
                    Text("Saved").frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .font(Font.system(size:23,weight:.semibold))
                    Text("Your measurement can be found in the history list!").multilineTextAlignment(.center)
                        .font(Font.system(size:16, weight: .semibold))
                        .padding(EdgeInsets(top:20,leading: 25, bottom:20, trailing: 45))
                        .foregroundColor(Color.black)
                    Button(action:{
                        withAnimation(.linear(duration:0.3)){
                        showPopUp = false
                        showPush = false
                        showPull = false }
                       
                    },label:{Text("Ok")}).padding()
                }
            }
        }.frame(maxWidth: 300)
            .border(Color.black, width:2)
            .background(Color.white)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
