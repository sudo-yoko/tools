PowerShell
## 静的コード解析を使用する方法
VSCodeを使用する場合
### VSCodeの[設定]
```
PowerShell › Script Analysis: Enable
```
PSScriptAnalyzerによるコード監視を有効にする。

### .vscodeのsettings.json
```
"powershell.scriptAnalysis.settingsPath": "./PSScriptAnalyzerSettings.psd1",
```
静的コード解析のルールを記述したファイルの配置場所を指定する。

## 実行時の動的型チェックを厳格モードで行う方法
プログラムの冒頭に以下を追加する
```
Set-StrictMode -Version 3.0     # 厳格モードを適用する
$ErrorActionPreference = "Stop" # エラーが起きたら即時停止する
```
※スクリプトの引数がある場合は、引数の後ろに記述する
例）
```
# スクリプトの引数
param(
    [switch]$Debug
)

# 厳格モードの適用
Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

# # ライブラリ（アセンブリ）の読み込み
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
```
