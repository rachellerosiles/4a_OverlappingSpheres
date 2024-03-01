//
//  ContentView.swift
//  MC_Integration
//
//  Created by Rachelle Rosiles on 2/9/24.
//


import SwiftUI

struct ContentView: View {
    
    //@State var integralE = 0.0
    @State var totalGuesses = 0.0
    @State var totalIntegral = 0.0
    @State var calcIntegral = 0.0
    @State var radius = 1.0
    @State var x1Value = 0.0
    @State var x2Value = 0.0
    @State var y1Value = 0.0
    @State var y2Value = 0.0
    @State var z1Value = 0.0
    @State var z2Value = 0.0
    
    
    @State var calcIntegralString = "0.0"
    @State var integralString = "0.0"
    @State var guessString = "23458"
    @State var totalGuessString = "0"
    @State var x1String = "0.0"
    @State var x2String = "0.0"
    @State var y1String = "0.0"
    @State var y2String = "0.0"
    @State var z1String = "0.0"
    @State var z2String = "0.0"
    
    
    
    // Setup the GUI to monitor the data from the Monte Carlo Integral Calculator
    @State var monteCarlo = MonteCarloWaves()
    
    //Setup the GUI View
    var body: some View {
        HStack{
            
            VStack{
                VStack{
                    HStack{
                        VStack(alignment: .center) {
                            Text("X coordinate of 1st orbital:")
                                .font(.callout)
                                .bold()
                            TextField("x", text: $x1String)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                        VStack(alignment: .center) {
                            Text("X coordinate of 2nd orbital")
                                .font(.callout)
                                .bold()
                            TextField("z", text: $x2String)
                                .padding()
                        }
                        .padding(.top, 5.0)
                    }
                    
                    HStack{
                        VStack(alignment: .center) {
                            Text("Y coordinate of 1st orbital")
                                .font(.callout)
                                .bold()
                            TextField("y", text: $y1String)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                        VStack(alignment: .center) {
                            Text("Y coordinate of 2nd orbital")
                                .font(.callout)
                                .bold()
                            TextField("y", text: $y2String)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                    }
                    
                    HStack{
                        VStack(alignment: .center) {
                            Text("Z coordinate of 1st orbital")
                                .font(.callout)
                                .bold()
                            TextField("z", text: $z1String)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                        VStack(alignment: .center) {
                            Text("Z coordinate of 2nd orbital")
                                .font(.callout)
                                .bold()
                            TextField("z", text: $z2String)
                                .padding()
                        }
                        .padding(.top, 5.0)
                    }
                    
                }
                VStack(alignment: .center) {
                    Text("Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Guesses", text: $guessString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                
                VStack(alignment: .center) {
                    Text("Total Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Total Guesses", text: $totalGuessString)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("Monte Carlo Integral")
                        .font(.callout)
                        .bold()
                    TextField("# integral", text: $integralString)
                        .padding()
                }
                
                
                Button("Cycle Calculation", action: {Task.init{await self.calculateIntegral()}})
                    .padding()
                    .disabled(monteCarlo.enableButton == false)
                
                Button("Clear", action: {self.clear()})
                    .padding(.bottom, 5.0)
                    .disabled(monteCarlo.enableButton == false)
                
                if (!monteCarlo.enableButton){
                    
                    ProgressView()
                }
                
                
            }
            .padding()
            
            //DrawingField
            
            
            /*drawingView(redLayer:$monteCarlo.insideData, blueLayer: $monteCarlo.outsideData)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
           */ // Stop the window shrinking to zero.
            Spacer()
            
        }
    }
    
    func calculateIntegral() async {
        
        monteCarlo.orbital1xCenter = x1Value
        monteCarlo.orbital2xCenter = y1Value
        monteCarlo.orbital1yCenter = z1Value
        
        monteCarlo.orbital2xCenter = x2Value
        monteCarlo.orbital2yCenter = y2Value
        monteCarlo.orbital2zCenter = z2Value
        
        
        await monteCarlo.setButtonEnable(state: false)
        
        monteCarlo.guesses = Int(guessString)!
        monteCarlo.xRange = radius
        monteCarlo.totalGuesses = Int(totalGuessString) ?? Int(0.0)
        
        await monteCarlo.calculateIntegral()
        
        totalGuessString = monteCarlo.totalGuessesString
        integralString =  monteCarlo.integralString
        
        await monteCarlo.setButtonEnable(state: true)
        
    }
    
    func clear(){
        
        guessString = "23458"
        totalGuessString = "0.0"
        integralString =  ""
        monteCarlo.totalGuesses = 0
        monteCarlo.totalIntegral = 0.0
        //monteCarlo.insideData = []
        //monteCarlo.outsideData = []
        monteCarlo.firstTimeThroughLoop = true
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
//monteCarlo = MonteCarloWaves(withData: true, xCenter1: x1Value, yCenter1: y1Value, zCenter1: z1Value, type1: "s", xCenter2: x2Value, yCenter2: y2Value, zCenter2: z2Value, type2: "s")
