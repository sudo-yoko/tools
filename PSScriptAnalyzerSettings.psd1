# PSScriptAnalyzerSettings.psd1 （超強制版）
@{
    # 推奨ルールをすべて含める
    IncludeRules = @('PS*')

    # 規則の設定をカスタマイズする
    Rules = @{
        # 未定義変数のチェックを「Warning（警告）」として絶対に出すように強制
        PSAvoidUsingUninitializedVariable = @{
            Enable = $true
        }
    }
}