
import SwiftUI
import SwiftUICharts


struct WeatherChartDetail: View {
    let city: City
    
    var body: some View {
                HStack {
                    if let tempList = city.tempList, let dates = city.dt_txtDate, let cityOnly = city.name {
                        LineChartDetail(data: tempList, labels: dates, cityOnly: cityOnly)
                            .frame(height: 300)
                    } else {
                        Text("Данные о погоде недоступны")
                    }
                }
            .background(Color(Palette.viewDinamecColor1))
        }
    
}

struct LineChartDetail: View {
    let data: [Float]
    let labels: [String]
    let cityOnly: String?
    let chartStyle = ChartStyle(backgroundColor: Color(Palette.viewDinamecColor1), accentColor: .cyan, secondGradientColor: .cyan, textColor: Color(Palette.labelDinamecColor), legendTextColor: Color(Palette.labelDinamecColor), dropShadowColor: .cyan)
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let cityOnly = cityOnly {
                Text("Temperature \(cityOnly)")
                    .font(.largeTitle)
                    .alignmentGuide(HorizontalAlignment.leading) { dimension in dimension[.leading] }
                    .foregroundColor(Color(Palette.labelDinamecColor))
            }
            Text("Weather")
                .font(.headline)
                .alignmentGuide(HorizontalAlignment.leading) { dimension in dimension[.leading] }
                .foregroundColor(Color(Palette.labelDinamecColorUI))
            ScrollView(.horizontal) {
                VStack {
                    LineView(data: data.map { Double($0) }, style: chartStyle)
                        .frame( height: 300)
                        
                    HStack {
                        ForEach(0..<labels.count, id: \.self) { index in
                            Text(self.labels[index])
                                .font(.caption)
                                .foregroundColor(Color(Palette.labelDinamecColor))
                                .frame(width: UIScreen.main.bounds.width / CGFloat(self.labels.count/6))
                            
                        }
                    }
                    .padding()
                }
            }
        }
    }
}



//#Preview {
//    LineChartDetail()
//}
