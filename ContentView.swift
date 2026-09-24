import SwiftUI

@main
struct GameBoostApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var isBoostEnabled = false
    @State private var showBurst = false
    @State private var pulse = false

    private let accent = Color(red: 0.18, green: 0.86, blue: 0.98)
    private let violet = Color(red: 0.50, green: 0.30, blue: 1.0)

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.035, green: 0.04, blue: 0.10), Color(red: 0.10, green: 0.04, blue: 0.19)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            Circle().fill(accent.opacity(0.12)).frame(width: 260).blur(radius: 50).offset(x: -130, y: -280)
            Circle().fill(violet.opacity(0.14)).frame(width: 320).blur(radius: 60).offset(x: 150, y: 240)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    header
                    boostOrb
                    metrics
                    actionRows
                    Text("製作人 CHEN")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.white.opacity(0.42))
                        .padding(.top, 4)
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 18)
            }
        }
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("NITRO MODE")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(accent)
                Text("遊戲效能中心")
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
            }
            Spacer()
            Image(systemName: "gamecontroller.fill")
                .font(.title2)
                .foregroundStyle(accent)
                .padding(13)
                .background(.white.opacity(0.09), in: Circle())
        }
    }

    private var boostOrb: some View {
        VStack(spacing: 18) {
            ZStack {
                Circle().stroke(accent.opacity(0.18), lineWidth: 2).frame(width: 206, height: 206)
                Circle().stroke(violet.opacity(0.5), lineWidth: 1).frame(width: 172, height: 172)
                Circle()
                    .fill(AngularGradient(colors: [accent, violet, accent], center: .center))
                    .frame(width: 138, height: 138)
                    .shadow(color: accent.opacity(0.55), radius: isBoostEnabled ? 30 : 12)
                    .scaleEffect(pulse ? 1.04 : 0.96)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulse)
                Image(systemName: isBoostEnabled ? "bolt.fill" : "power")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundStyle(.white)
            }
            Text(isBoostEnabled ? "BOOST 已啟用" : "準備就緒")
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text(isBoostEnabled ? "低干擾模式運作中" : "一鍵進入遊戲專注模式")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.56))
            Button(action: toggleBoost) {
                HStack(spacing: 9) {
                    Image(systemName: isBoostEnabled ? "stop.fill" : "bolt.fill")
                    Text(isBoostEnabled ? "關閉模式" : "啟動 BOOST")
                }
                .font(.headline.weight(.bold))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity).padding(.vertical, 16)
                .background(accent, in: RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
        .overlay { if showBurst { BurstView(color: accent).allowsHitTesting(false) } }
    }

    private var metrics: some View {
        HStack(spacing: 12) {
            Metric(title: "裝置溫度", value: "32°", icon: "thermometer.medium", color: .green)
            Metric(title: "專注狀態", value: isBoostEnabled ? "ON" : "OFF", icon: "moon.fill", color: violet)
            Metric(title: "模式", value: "遊戲", icon: "speedometer", color: accent)
        }
    }

    private var actionRows: some View {
        VStack(spacing: 12) {
            SettingRow(icon: "bell.slash.fill", title: "遊戲專注提醒", detail: "開啟後可前往系統專注模式")
            SettingRow(icon: "gearshape.2.fill", title: "系統設定捷徑", detail: "快速檢查低耗電與顯示設定")
        }
    }

    private func toggleBoost() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.7)) { isBoostEnabled.toggle() }
        pulse = isBoostEnabled
        if isBoostEnabled {
            showBurst = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { showBurst = false }
        }
    }
}

struct Metric: View {
    let title: String; let value: String; let icon: String; let color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Image(systemName: icon).foregroundStyle(color)
            Text(value).font(.title3.weight(.bold)).foregroundStyle(.white)
            Text(title).font(.caption).foregroundStyle(.white.opacity(0.5))
        }.frame(maxWidth: .infinity, alignment: .leading).padding(14)
            .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 15))
    }
}

struct SettingRow: View {
    let icon: String; let title: String; let detail: String
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon).foregroundStyle(.cyan).frame(width: 22)
            VStack(alignment: .leading, spacing: 3) { Text(title).foregroundStyle(.white).font(.subheadline.weight(.semibold)); Text(detail).foregroundStyle(.white.opacity(0.45)).font(.caption) }
            Spacer(); Image(systemName: "chevron.right").foregroundStyle(.white.opacity(0.3)).font(.caption)
        }.padding(16).background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 15))
    }
}

struct BurstView: View {
    let color: Color
    @State private var scale: CGFloat = 0.2
    var body: some View {
        ZStack { ForEach(0..<12, id: \.self) { i in Capsule().fill(color).frame(width: 4, height: 34).offset(y: -100).rotationEffect(.degrees(Double(i) * 30)).scaleEffect(scale) } }
            .onAppear { withAnimation(.easeOut(duration: 0.7)) { scale = 1.0 } }
    }
}
