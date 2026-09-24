# Nitro Mode iOS 原型

`ContentView.swift` 是一個可放入 Xcode SwiftUI App 專案的單檔原型，包含：

- 啟用／關閉 BOOST 模式
- 啟用時的粒子爆發動畫與狀態變化
- 裝置溫度、專注狀態、模式資訊卡
- 遊戲專注提醒與系統設定捷徑的介面入口
- 「製作人 CHEN」署名

## 重要限制

iOS 第三方 App 不能在背景替其他 App 關閉程序、清理系統 RAM、調整 CPU/GPU 頻率，或持續運行一個全機遊戲加速服務。這份原型因此把 BOOST 定位為視覺化的遊戲專注模式；正式版可再接入 `AppIntents`、`ManagedSettings`（需要相應權限）與使用者自己的遊戲內設定引導。

## 使用方式

在 Xcode 建立 `iOS App`（SwiftUI、Swift），以本檔內容取代產生的 Swift 檔，部署目標建議 iOS 16.0 或以上。
