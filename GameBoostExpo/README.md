# GameBoost（Windows + GitHub 雲端打包）

## 第一次設定

1. 將整個 `GameBoostExpo` 資料夾上傳到 GitHub。
2. Windows PowerShell 執行：`npm.cmd install -g eas-cli`、`eas.cmd login`。
3. 在專案資料夾執行：`eas.cmd build:configure`。
4. 執行 `eas.cmd project:info`，把產生的 projectId 填入 `app.json`。
5. 到 Expo 帳號建立 Access Token，GitHub 專案的 Settings > Secrets > Actions 新增 `EXPO_TOKEN`。

## GitHub 打包

GitHub 的 Actions > Build iOS IPA > Run workflow。第一次打包時 EAS 會要求你登入 Apple Developer 並建立簽名憑證；這些操作在 Windows 瀏覽器完成，不需要 Mac。

`preview` 產生的 IPA 需要裝置註冊（Ad Hoc）。要給一般使用者安裝，改用 `production` 並上傳 TestFlight：`eas.cmd build --platform ios --profile production`，再執行 `eas.cmd submit --platform ios`。

此 App 是遊戲專注模式介面；iOS 不允許第三方 App 在背景替其他遊戲調 CPU/GPU 或清理系統記憶體。
