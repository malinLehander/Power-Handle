//
//  HistoryView.swift
//  project2021
//
//  Created by Malin Lehander on 2021-12-20.
//


import SwiftUI
import SwiftUICharts

struct HistoryView: View{
    @EnvironmentObject var viewModel: MeasurementViewModel

    @State private var showPopUp: Bool = false
    @State var i = 0
    
    init(){
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = true
    }
    
    var body: some View{
        ZStack{
            NavigationView{
                ZStack{
                    Color.clear
                    ScrollView{
                        ZStack{
                            LazyVGrid(columns: [GridItem()]){
                                ForEach(0..<viewModel.measurements.count, id:\.self){measurementObject in
                                    HStack{
                                        let name = viewModel.getObjectAtIndex(index: measurementObject)
                                        NavigationLink(destination: measurementView(index: measurementObject)){
                                            Text("\(name)")
                                        }.padding(.horizontal).foregroundColor(.black)

                                
                                        Spacer()
                                        Button(action:{
                                            withAnimation(.linear(duration:0.2)){
                                                showPopUp.toggle()
                                            }
                                            i = measurementObject
                                    
                                        },
                                               label:{
                                            Image(systemName: "trash")}
                                        ).padding(.horizontal).foregroundColor(.red)
                                }
                            }
                        }.frame(maxWidth:.infinity)
                    }
                }
          }.navigationBarTitleDisplayMode(.inline).navigationTitle("Earlier Measurements").foregroundColor(Color.clear)
        }
            PopUpWindow(show: $showPopUp, index: i)
        }
        
    }
}

struct measurementView: View {
    
    var index: Int
    @EnvironmentObject var viewModel: MeasurementViewModel
    
    var body: some View{
        let listOfValues = viewModel.getValuesOfObject(index: index)
        let doubles = viewModel.getFloatAsDouble(value: listOfValues)
            ZStack{
                VStack{
                    LineView(data: doubles, title: "Measurement: ", legend: "\(viewModel.getObjectAtIndex(index: index))")
                    Spacer()
                    Text("Average = \(viewModel.calculateAverage(list: listOfValues)) N")
                    Spacer()
                    Spacer()
                }
            }
        
    }
}

struct PopUpWindow: View{
    @EnvironmentObject var viewModel: MeasurementViewModel
    @Binding var show: Bool
    var index: Int
    
    var body: some View{
        ZStack{
            if show{
                VStack{
                    Text("Delete")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .font(Font.system(size:23,weight:.semibold))
                    
                    Text("Are you sure you want to delete this measurement?")
                        .multilineTextAlignment(.center)
                        .font(Font.system(size:16, weight: .semibold))
                        .padding(EdgeInsets(top:20,leading: 25, bottom:20, trailing: 45))
                        .foregroundColor(Color.black)
                    HStack{
                        Button(action:{
                            withAnimation(.linear(duration:0.3)){
                               show = false
                            }
                            viewModel.removeObject(index: index)
                        }, label:{
                                Text("Yes").padding()
                        })
                        Button(action:{
                            withAnimation(.linear(duration:0.3)){
                                show = false
                            }}, label:{
                                Text("No").padding()
                        })}}
            }
        }.frame(maxWidth: 300)
            .border(Color.black, width:2)
            .background(Color.white)
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
