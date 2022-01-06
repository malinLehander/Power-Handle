//
//  SettingsView.swift
//  project2021
//
//  Created by Malin Lehander on 2021-12-20.
//

import SwiftUI

struct SettingsView: View{
    @EnvironmentObject var viewModel: MeasurementViewModel
    @State var isConnectedToDevice = ""
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
            Button(
                action: {
                    viewModel.StartBLTButtonPressed((Any).self)
                    DispatchQueue.main.asyncAfter(deadline: .now()+3){
                        if viewModel.isConnected()==true {
                            isConnectedToDevice = "Connected to Arduino"
                        }
                        else{
                            isConnectedToDevice = "Cannot find device"
                        }
                    }
                } ,
                label:{HStack{
                    Text("Connect To Device").font(.headline).fontWeight(.bold).foregroundColor(.white).padding().padding(.horizontal,20).background(Color.green.cornerRadius(20).shadow(radius: 5))}})
                Spacer()
                Text(isConnectedToDevice)
                Spacer()
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
