//

//  ContentView.swift

//  Access

//

//  Created by localuser on 06.05.20.

//  Copyright © 2020 localuser. All rights reserved.

//


import SwiftUI
import GameplayKit

struct Fonts {
  static func avenirNextCondensedBold (size:CGFloat) -> Font{
    return Font.custom("AvenirNextCondensed-Bold",size: size)
  }
  
  static func avenirNextCondensedMedium (size:CGFloat) -> Font{
    return Font.custom("AvenirNextCondensed-Medium",size: size)
  }
}

let dotSize:CGFloat = 24
let diceSize:CGFloat = 128
let fieldSide:CGFloat = 32

let d6 = GKRandomDistribution.d6()

var diceViews:[AnyView] = [AnyView(oneDotDice()),AnyView(twoDotDice()),AnyView(threeDotDice(turn: true)),AnyView(fourDotDice())]

struct ContentView: View {
  @State var showView = true
  @State var degree:Double = 0
  @State var mover = CGSize(width:0, height:0)
  @State var swinger:UnitPoint = .trailing
  @State var wildcard:CGFloat = 0
  @State var action:CGFloat = -1
  @State var lowInt:Int = 0
  @State var midInt:Int = 1
  @State var highInt:Int = 2
  @State var ultraInt:Int = 3
  @State var q1 = CGSize(width: 0, height: 0)
  @State var q2 = CGSize(width: 128, height: 0)
  @State var q3 = CGSize(width: 128, height: 0)
  @State var q4 = CGSize(width: 128, height: 0)
  @State var p1 = 0
  @State var p2 = 90
  @State var p3 = 90
  @State var p4 = 90
  @State var z1:CGFloat = 1
  @State var z2:CGFloat = 1
  @State var z3:CGFloat = 1
  @State var z4:CGFloat = 1
  @State var f1:UnitPoint = .leading
  @State var f2:UnitPoint = .leading
  @State var f3:UnitPoint = .leading
  @State var f4:UnitPoint = .leading
  var body: some View {
    VStack {
      ZStack {
        Rectangle()
          //          .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .leading, endPoint: .trailing))
          .stroke(Color.black)
          .frame(width: 128, height: 128, alignment: .center)
        
        //          Image(systemName: "arrow.left.circle")
        //            .resizable()
        //            .frame(width: 96, height: 96, alignment: .center)
        //            .foregroundColor(Color.white)
        Circle()
          //          .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
          .stroke(Color.black)
          .frame(width: 120, height: 120, alignment: .center)
        
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
        
        //        VStack {
        //          Text("Better")
        //            .foregroundColor(Color.white)
        //            .font(Fonts.avenirNextCondensedBold(size: 16))
        //          Text("Programming")
        //            .foregroundColor(Color.white)
        //            .font(Fonts.avenirNextCondensedBold(size: 16))
        //        }
      }.rotation3DEffect(.degrees(degree), axis: (x: 0, y: action, z: 0), anchor: swinger, anchorZ: wildcard, perspective: 0.2)
        .onTapGesture {
          self.swinger = UnitPoint.trailing
          self.action = -1
          self.degree = 0
          self.mover.width = 0
          withAnimation(.linear(duration: 1)) {
            self.degree = 90
            self.mover.width -= 128
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.swinger = UnitPoint.leading
            self.action = -1
            self.mover.width = 0
            withAnimation(.linear(duration: 1)) {
              self.degree = 180
              self.mover.width = 128
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
              self.swinger = UnitPoint.trailing
              self.action = -1
              self.mover.width = -128
              withAnimation(.linear(duration: 1)) {
                self.degree = 270
                self.mover.width = 0
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.swinger = UnitPoint.leading
                self.action = 1
                self.mover.width = 128
                self.degree = 90
                withAnimation(.linear(duration: 1)) {
                  self.degree = 0
                  self.mover.width = 0
                }
              })
            })
          })
      }
      .offset(mover)
      
      
      
      ZStack {
        diceViews[lowInt]
          .rotation3DEffect(.degrees(Double(p1)), axis: (x: 0, y: self.z1, z: 0), anchor: self.f1, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q1)
          .gesture(DragGesture()
            .onEnded { value in
              if value.translation.width > 30 {
                self.z1 = 1
                self.z4 = -1
                self.f1 = UnitPoint.leading
                self.f4 = UnitPoint.trailing
                self.q4.width = -128
                
                withAnimation(.linear(duration: 0.5)) {
                  self.p1 = 90
                  self.q1.width = 128
                  self.p4 = 0
                  self.q4.width = 0
                }
              }
              if value.translation.width < 30 {
                self.z1 = -1
                self.z2 = 1
                self.f1 = UnitPoint.trailing
                self.f2 = UnitPoint.leading
                self.q2.width = 128
                
                withAnimation(.linear(duration: 0.5)) {
                  self.p1 = 90
                  self.q1.width = -128
                  self.p2 = 0
                  self.q2.width = 0
                }
              }
            }
        )
        
        
        diceViews[midInt]
          .rotation3DEffect(.degrees(Double(p2)), axis: (x: 0, y: self.z2, z: 0), anchor: self.f2, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q2)
          .gesture(DragGesture()
            .onEnded { value in
              if value.translation.width > 30 {
                self.z2 = 1
                self.z1 = -1
                self.f2 = UnitPoint.leading
                self.f1 = UnitPoint.trailing
                self.q1.width = -128
          
                withAnimation(.linear(duration: 0.5)) {
                  self.p2 = 90
                  self.q2.width = 128
                  
                  self.p1 = 0
                  self.q1.width = 0
                }
              }
              if value.translation.width < 30 {
                self.z2 = -1
                self.z3 = 1
                self.f2 = UnitPoint.trailing
                self.f3 = UnitPoint.leading
                self.q3.width = 128
                
                withAnimation(.linear(duration: 0.5)) {
                  self.p2 = 90
                  self.q2.width = -128
                  self.p3 = 0
                  self.q3.width = 0
                }
              }
            }
        )
        
        diceViews[highInt]
          .rotation3DEffect(.degrees(Double(p3)), axis: (x: 0, y: self.z3, z: 0), anchor: self.f3, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q3)
          .gesture(DragGesture()
            .onEnded { value in
              if value.translation.width > 30 {
                self.z3 = 1
                self.z2 = -1
                self.f3 = UnitPoint.leading
                self.f2 = UnitPoint.trailing
                self.q2.width = -128
                
                withAnimation(.linear(duration: 0.5)) {
                  self.p3 = 90
                  self.q3.width = 128
                  self.p2 = 0
                  self.q2.width = 0
                }
              }
              if value.translation.width < 30 {
                self.z3 = -1
                self.z4 = 1
                self.f3 = UnitPoint.trailing
                self.f4 = UnitPoint.leading
                self.q4.width = 128
                
                withAnimation(.linear(duration: 0.5)) {
                  self.p3 = 90
                  self.q3.width = -128
                  self.p4 = 0
                  self.q4.width = 0
                }
              }
            }
        )
        
        diceViews[ultraInt]
          .rotation3DEffect(.degrees(Double(p4)), axis: (x: 0, y: self.z4, z: 0), anchor: self.f4, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q4)
          .gesture(DragGesture()
            .onEnded { value in
              if value.translation.width > 30 {
                self.z4 = 1
                self.z3 = -1
                self.f4 = UnitPoint.leading
                self.f3 = UnitPoint.trailing
                self.q3.width = -128
                
                
                withAnimation(.linear(duration: 0.5)) {
                  self.p4 = 90
                  self.q4.width = 128
                  self.p3 = 0
                  self.q3.width = 0
                }
              }
              if value.translation.width < 30 {
                self.z4 = -1
                self.z1 = 1
                self.f4 = UnitPoint.trailing
                self.f1 = UnitPoint.leading
                self.q1.width = 128
                
                
                withAnimation(.linear(duration: 0.5)) {
                  self.p4 = 90
                  self.q4.width = -128
                  self.p1 = 0
                  self.q1.width = 0
                }
              }
            }
        )
      }
      
    }
  }
}

struct oneDotDiceV: View {
  var body: some View {
    //    Image("d1")
    //      .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
  }
}

struct twoDotDiceV: View {
  var body: some View {
    //    Image("d2")
    //    .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
  }
}

struct threeDotDiceV: View {
  var body: some View {
    //    Image("d3")
    //    .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
    
  }
}

struct fourDotDiceV: View {
  var body: some View {
    //    Image("d4")
    //    .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
    
  }
}

struct fiveDotDiceV: View {
  var body: some View {
    Image("d5")
  }
}

struct sixDotDiceV: View {
  var body: some View {
    Image("d6")
  }
}


struct oneDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //        .border(Color.black)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
    }
  }
}

struct twoDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(Color.black)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      HStack {
        Spacer()
        Circle()
          .fill(Color.white)
          .frame(width: dotSize, height: dotSize, alignment: .center)
        Spacer()
        Circle()
          .fill(Color.white)
          .frame(width: dotSize, height: dotSize, alignment: .center)
        Spacer()
      }.frame(width: diceSize, height: diceSize, alignment: .center)
    }
  }
}

struct threeDotDice: View {
  @State var turn:Bool
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(turn ? Color.black: Color.clear)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      HStack {
        Spacer()
        Circle()
          .fill(Color.white)
          .frame(width: dotSize, height: dotSize, alignment: .center)
        Spacer()
        Circle()
          .fill(Color.white)
          .frame(width: dotSize, height: dotSize, alignment: .center)
        Spacer()
        Circle()
          .fill(Color.white)
          .frame(width: dotSize, height: dotSize, alignment: .center)
        Spacer()
      }.frame(width: diceSize, height: diceSize, alignment: .center)
        .rotationEffect(turn ? .degrees(45) : .degrees(0))
    }
  }
}

struct fourDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(Color.black)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      VStack {
        HStack {
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide)
        } // HStack
        Spacer()
          .frame(height: fieldSide )
        HStack {
          Spacer()
            .frame(width: fieldSide)
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide)
        } // HStack
      }.frame(width: diceSize, height: diceSize, alignment: .center)
      //VStack
      
    }
  }
}

struct fiveDotDice: View {
  var body: some View {
    ZStack {
      fourDotDice()
      oneDotDice()
    }
  }
}

struct sixDotDice: View {
  var body: some View {
    Rectangle()
      .fill(Color.clear)
      .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(Color.black)
      .background(
        ZStack {
          VStack {
            Spacer()
            threeDotDice(turn: false)
              .offset(CGSize(width: 0, height: fieldSide * 1.3))
            threeDotDice(turn: false)
              .offset(CGSize(width: 0, height: -fieldSide * 1.3))
            Spacer()
          }
      })
  }
}


extension Color {
  init(_ hex: Int, opacity: Double = 1.0) {
    let red = Double((hex & 0xff0000) >> 16) / 255.0
    let green = Double((hex & 0xff00) >> 8) / 255.0
    let blue = Double((hex & 0xff) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
  }
}
