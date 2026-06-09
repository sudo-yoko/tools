# Unicodeエスケープされた文字列
$escaped = "\u5909\u63db\u3057\u307e\u3059\u3002"

# 変換
$text = [regex]::Unescape($escaped)

# 結果をクリップボードにコピー
$text | Set-Clipboard

# コンソールに出力
Write-Output $text
