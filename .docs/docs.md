PowerShell
## 静的コード解析を使用する方法
VSCodeを使用する場合
```jsonc
// settings.json

// PSScriptAnalyzerによるコード監視を有効にする。
"powershell.scriptAnalysis.enable": true,

// 静的コード解析のルールを記述したファイルの配置場所を指定する。
"powershell.scriptAnalysis.settingsPath": "./PSScriptAnalyzerSettings.psd1",
```

PSScriptAnalyzerSettings.psd1の例

```powershell
# PSScriptAnalyzerSettings.psd1
@{
    # 既定のルールを含める
    IncludeDefaultRules = $true
}
```

## 実行時の動的型チェックを厳格モードで行う方法
プログラム冒頭に以下を追加する。
```powershell
# .ps1

Set-StrictMode -Version 3.0         # 厳格モードを適用する
$ErrorActionPreference = "Stop"     # エラーが起きたら即時停止する
```
スクリプトの引数がある場合は、引数定義の後ろに記述する。  
例）
```powershell
# .ps1

# スクリプトの引数
param(
    [switch]$Debug
)

# 厳格モードの適用
Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

# ライブラリ（アセンブリ）の読み込み
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

...
```
