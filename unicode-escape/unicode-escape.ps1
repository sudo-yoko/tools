# 変換するテキスト
$text = "変換します。"

# 変換
$escaped = ($text.toCharArray() | ForEach-Object { "\u{0:x4}" -f [int]$_ }) -join ""

# 結果をクリップボードにコピー
$escaped | Set-Clipboard

# コンソールに出力
Write-Output $escaped