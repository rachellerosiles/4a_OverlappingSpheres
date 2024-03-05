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
    @State var radius = 0.0
    @State var xLimitPos = 10.0
    @State var xLimitNeg = -10.0
    @State var yLimitPos = 0.0
    @State var yLimitNeg = 0.0
    @State var zLimitPos = 0.0
    @State var zLimitNeg = 0.0
    
    @State var radiusString = "0.0"
    @State var calcIntegralString = "0.0"
    @State var integralString = "0.0"
    @State var guessString = "23458"
    @State var totalGuessString = "0"
    @State var xLimitPosString = "10.0"
    @State var xLimitNegString = "-10.0"
    @State var yLimitPosString = "10.0"
    @State var yLimitNegString = "-10.0"
    @State var zLimitPosString = "10.0"
    @State var zLimitNegString = "-10.0"
    
    
    
    // Setup the GUI to monitor the data from the Monte Carlo Integral Calculator
    @State var monteCarlo = MonteCarloWaves()
    
    //Setup the GUI View
    var body: some View {
        HStack{
            
            VStack{
                VStack{
                    HStack{
                        VStack(alignment: .center) {
                            Text("X Positive imit:")
                                .font(.callout)
                                .bold()
                            TextField("x", text: $xLimitPosString)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                        VStack(alignment: .center) {
                            Text("X Negative Limit")
                                .font(.callout)
                                .bold()
                            TextField("z", text: $xLimitNegString)
                                .padding()
                        }
                        .padding(.top, 5.0)
                    }
                    
                    HStack{
                        VStack(alignment: .center) {
                            Text("Y Positive Limit")
                                .font(.callout)
                                .bold()
                            TextField("y", text: $yLimitPosString)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                        VStack(alignment: .center) {
                            Text("Y Negative Limit")
                                .font(.callout)
                                .bold()
                            TextField("y", text: $yLimitNegString)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                    }
                    
                    HStack{
                        VStack(alignment: .center) {
                            Text("Z Positive Limit")
                                .font(.callout)
                                .bold()
                            TextField("z", text: $zLimitPosString)
                                .padding()
                        }
                        .padding(.top, 5.0)
                        
                        VStack(alignment: .center) {
                            Text("Z Negative Limit")
                                .font(.callout)
                                .bold()
                            TextField("z", text: $zLimitNegString)
                                .padding()
                        }
                        .padding(.top, 5.0)
                    }
                    
                }
                
                VStack(alignment: .center) {
                    Text("Interatomic Spacing")
                        .font(.callout)
                        .bold()
                    TextField("radius", text: $radiusString)
                        .padding()
                }
                .padding(.top, 5.0)
                
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
                
                
                Button("Cycle Calculation", action: {self.calculateIntegral()})
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
    
    func calculateIntegral() {
        
        //assume bond axis is x-axis
        radius = Double(radiusString) ?? 0.0
        let xCenterAtom1 = -radius/2
        let yCenterAtom1 = 0.0
        let zCenterAtom1 = 0.0
        
        let xCenterAtom2 = radius/2
        let yCenterAtom2 = 0.0
        let zCenterAtom2 = 0.0
        
        monteCarlo.orbital1xCenter = xCenterAtom1
        monteCarlo.orbital2xCenter = yCenterAtom1
        monteCarlo.orbital1yCenter = zCenterAtom1
        
        monteCarlo.orbital2xCenter = xCenterAtom2
        monteCarlo.orbital2yCenter = yCenterAtom2
        monteCarlo.orbital2zCenter = zCenterAtom2
        
        monteCarlo.xLimitPos = Double(xLimitPosString) ?? 10.0
        monteCarlo.xLimitNeg = Double(xLimitNegString) ?? -10.0
        monteCarlo.yLimitPos = Double(yLimitPosString) ?? 10.0
        monteCarlo.yLimitNeg = Double(yLimitNegString) ?? -10.0
        monteCarlo.zLimitPos = Double(zLimitPosString) ?? 10.0
        monteCarlo.zLimitNeg = Double(zLimitNegString) ?? -10.0
        
        
        
        monteCarlo.setButtonEnable(state: false)
        
        monteCarlo.guesses = Int(guessString)!
      
        monteCarlo.totalGuesses = Int(totalGuessString) ?? Int(0.0)
        
        monteCarlo.calculateIntegral()
        
        totalGuessString = monteCarlo.totalGuessesString
        integralString =  monteCarlo.integralString
        
        monteCarlo.setButtonEnable(state: true)
        
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
