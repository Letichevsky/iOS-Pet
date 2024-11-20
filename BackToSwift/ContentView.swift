//
//  ContentView.swift
//  BackToSwift
//
//  Created by VL on 19/10/2024.
//

import SwiftUI


struct FirstPage: View {
    @State var count: Int = 0
    
    func counterPlus() {
        count += 1
    }
    
    func counterMinus() {
        count -= 1
    }
    
    var body: some View {
        VStack {
            Text("Count is: \(count)")
                .font(.title)
            HStack {
                Button("count -") {
                    counterMinus()
                }
                .foregroundColor(Color.white)
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(25)
                
                Button("count +") {
                    counterPlus()
                }
                .foregroundColor(Color.white)
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(25)
            }
        }
    }
}

struct SecondPage: View {
    var colors: [Color] = [Color.green, Color.yellow, Color.red, Color.orange, Color.blue, Color.purple]
    @State var showNewScreen: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 25) {
                    ForEach(0..<colors.count, id: \.self) { index in
                        TabView {
                                ForEach(0..<colors.count, id: \.self) { index in
                                    ZStack {
                                        VStack(spacing: 0) {
                                            Image("photo")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 300, height: 250)
                                            
                                            VStack {
                                                Text("Amazing card \(index)!")
                                                    .foregroundColor(Color.white)
                                                Button("show more") {
                                                    showNewScreen = true
                                                }
                                                .padding()
                                                .padding(.horizontal)
                                                .background(Color.black)
                                                .foregroundColor(.white)
                                                .cornerRadius(20)
                                            }
                                            .frame(width: 300, height: 150)
                                                
                                                
                                        }
                                        .frame(width: 300, height: 400, alignment: .top)
                                        .background(colors[index])
                                        .cornerRadius(25)
                                    }
                                }
                        }
                        .frame(height: 400)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
            }
            .frame(maxWidth: .infinity)
            .sheet(isPresented: $showNewScreen, content: {
                ChangeColorPage()
            })
        }
    }
}

struct ThirdPage: View {
    @State var isActive: Bool = false
    @State var changeSize: Bool = false
    @State var rotate: Bool = false
    @State var aligment: Alignment = .center
    
    var body: some View {
        ZStack() {
            VStack {
                ZStack() {
                    ZStack(alignment: .topTrailing) {
                        Rectangle()
                            .fill(Color.yellow)
                        Circle()
                            .fill(Color.green)
                            .frame(width: changeSize ? 50 : 10, height: changeSize ? 50 : 10)
                            .padding(20)
                    }
                    .frame(width: changeSize ? 300 : 100, height: changeSize ? 300 : 100)
                    .cornerRadius(20)
                    .rotationEffect(Angle(degrees: rotate ? 360 : 0))
                    .animation(.spring(duration: 2, bounce: 0.2, blendDuration: 0.1), value: rotate)
                    .animation(.spring(duration: 1, bounce: 0.2, blendDuration: 0.1), value: changeSize)
                    .padding()
                }
                .frame(maxWidth: .infinity, minHeight: 400, alignment: aligment)
                .animation(.easeInOut(duration: 1), value: aligment)
                    
                
                Spacer()
                
                VStack {
                    HStack {
                        Button(action: {
                                changeSize.toggle()
                            
                        }, label: {
                            Text("change size")
                                .foregroundColor(Color.white)
                                .padding(20)
                                .background(Color.blue.cornerRadius(20))
                        })
                        
                        Button(action: {
                            rotate.toggle()
                        }, label: {
                            Text("rotate")
                                .foregroundColor(Color.white)
                                .padding(20)
                                .background(Color.blue.cornerRadius(20))
                        })
                    }
                    HStack {
                        Button(action: {
                            aligment = .leading
                            
                        }, label: {
                            Text("left")
                                .foregroundColor(Color.white)
                                .padding(20)
                                .background(Color.blue.cornerRadius(20))
                        })
                        
                        Button(action: {
                            aligment = .center
                            
                        }, label: {
                            Text("center")
                                .foregroundColor(Color.white)
                                .padding(20)
                                .background(Color.blue.cornerRadius(20))
                        })
                        
                        Button(action: {
                            aligment = .trailing
                        }, label: {
                            Text("right")
                                .foregroundColor(Color.white)
                                .padding(20)
                                .background(Color.blue.cornerRadius(20))
                        })
                    }
                }
            }
            .padding(.vertical, 100)
        }
        .frame(maxWidth: .infinity, maxHeight: 700)
    }
}

struct FourthPage: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var colors: [Color] = [Color.green, Color.yellow, Color.red, Color.orange, Color.blue, Color.purple, Color.green, Color.yellow, Color.red, Color.orange, Color.blue, Color.purple]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        Color.gray
                            .frame(width: UIScreen.main.bounds.width, height: 400)
                        Text("Fourth page")
                    }
                    .background(Color.gray)
                    
                        LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<colors.count, id: \.self) { index in
                                    NavigationLink(destination: screenWithAlert()) {
                                        GeometryReader { geometri in
                                            Rectangle()
                                                .fill(colors[index])
                                                .frame(width: geometri.size.width, height: geometri.size.width)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                }
                        }
                }
            }
            .navigationTitle(Text("Fourht page"))
        }
    }
}

struct ChangeColorPage: View {
    var bgColors: [Color] = [Color.white, Color.green, Color.yellow, Color.red, Color.orange, Color.blue, Color.purple]
    @State var numberOfColor: Int = 0
    
    func changeColor() {
        if (numberOfColor == bgColors.count - 1) {
            numberOfColor = 0
        } else {
            numberOfColor += 1
        }
    }
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Press button to change color")
                .foregroundColor(numberOfColor == 0 ? Color.black : Color.white)
            Button("change color") {
                changeColor()
            }
            .padding()
            .padding(.horizontal)
            .background(numberOfColor == 6 ? Color.yellow : Color.purple)
            .foregroundColor(numberOfColor == 6 ? Color.black : Color.white)
            .cornerRadius(25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        .background(bgColors[numberOfColor])
    }
}

struct screenWithAlert: View {
    
    @State var showAlert: Bool = false
    @State var showActionList: Bool = false
    @State var bgColor: Color = Color.black
    
    var body: some View {
        VStack(spacing: 20) {
            bgColor
                .frame(width: 250, height: 250)
                .cornerRadius(25)
                .shadow(color: .gray, radius: 4)
                .contextMenu(menuItems: {
                    Button(action: {
                        bgColor = Color.teal
                    }, label: {
                        Label("Teal", systemImage: "paintpalette")
                    })
                    Button(action: {
                        bgColor = Color.cyan
                    }, label: {
                        Label("Cyan", systemImage: "paintpalette")
                    })
                    Button(action: {
                        bgColor = Color.mint
                    }, label: {
                        Label("Mint", systemImage: "paintpalette")
                    })
                })
            
            VStack(spacing: 20) {
                Text("Screen with alerts")
                    .font(.title)
                HStack(spacing: 10) {
                    Button("Alert") {
                        showAlert.toggle()
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .alert("Change color", isPresented: $showAlert) {
                        Button("Reset", role: .destructive) {
                            bgColor = Color.black
                        }
                        Button("Blue", role: .cancel) {
                            bgColor = Color.blue
                        }
                        } message: {
                            Text("What a new bg color you whant?")
                    }
                    Button("Action list"){
                        showActionList.toggle()
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .actionSheet(isPresented: $showActionList) {
                        ActionSheet(
                            title: Text("More colors"),
                            message: Text("Choose a new color"),
                            buttons: [
                                .default(Text("Yellow")) {
                                    bgColor = Color.yellow
                                },
                                .default(Text("Green")) {
                                    bgColor = Color.green
                                },
                                .default(Text("Red")) {
                                    bgColor = Color.red
                                },
                                .default(Text("Orange")) {
                                    bgColor = Color.orange
                                },
                                .default(Text("Purple")) {
                                    bgColor = Color.purple
                                },
                                .default(Text("Pink")) {
                                    bgColor = Color.pink
                                },
                                .destructive(Text("Reset to black")) {
                                    bgColor = Color.black
                                },
                                .cancel(Text("Cancel"))
                            ]
                        )
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        
        TabView {
            FirstPage().tabItem {
                Label("First", systemImage: "car.rear.road.lane")
            }
            SecondPage().tabItem {
                Label("Second", systemImage: "magnifyingglass")
            }
            ThirdPage().tabItem {
                Label("Third", systemImage: "cart")
            }
            FourthPage().tabItem {
                Label("Fourth", systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    ContentView()
}
