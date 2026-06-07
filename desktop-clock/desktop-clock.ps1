# 引数
param(
    [switch]$Debug
)

# 厳格モードの適用
Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

# ライブラリ（アセンブリ）の読み込み
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#####################
# フォームの作成
#####################
$form = New-Object System.Windows.Forms.Form
$form.AutoSize = $true
$form.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.MaximizeBox = $false
$form.TopMost = $true
$form.Opacity = 0.9
$foddrm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle

# タイトルバーを消す
$form.Text = ""
$form.ControlBox = $false

#####################
# レイアウトコンテナ
#####################
$container = New-Object System.Windows.Forms.FlowLayoutPanel
$container.AutoSize = $true
$container.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$container.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$container.WrapContents = $false
$container.Padding = New-Object System.Windows.Forms.Padding(5, 5, 0, 0)
$form.Controls.Add($container)

#####################
# 時計のラベル
#####################
$timeLabel = New-Object System.Windows.Forms.Label
$timeLabel.AutoSize = $false
$timeLabel.Size = New-Object System.Drawing.Size(280, 40)
$timeLabel.Anchor = [System.Windows.Forms.AnchorStyles]::None   # コンテナの上下中央に配置
$timeLabel.Font = New-Object System.Drawing.Font("Arial", 20)
$timeLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$container.Controls.Add($timeLabel)

#####################
# 閉じるボタン
#####################
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.AutoSize = $false
$closeButton.Size = New-Object System.Drawing.Size(70, 40)
$closeButton.Anchor = [System.Windows.Forms.AnchorStyles]::None # コンテナの上下中央に配置
$closeButton.Font = New-Object System.Drawing.Font("Arial", 20)
$closeButton.Text = "×"
$container.Controls.Add($closeButton)

#####################
# 起動時に時刻を表示
#####################
function RefreshTime {
    $timeLabel.Text = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}
RefreshTime

#####################
# 1秒ごとに時刻を更新
#####################
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
        RefreshTime
    })
$timer.Start()

#####################
# 閉じるボタン押下時
#####################
$closeButton.Add_Click({
        $form.Close();
    })

#####################
# フォームの移動
#####################
# マウスが押された瞬間のクリック位置を記憶しておく変数
$script:mousePoint = [System.Drawing.Point]::Empty

# フォーム、コンテナ、時計ラベルに同じイベントを登録する
$dragTargets = @($form, $container, $timeLabel)
foreach ($target in $dragTargets) {
    # マウスが押された時
    $target.Add_MouseDown({
            param($_sender, $e)
            if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
                $script:mousePoint = New-Object System.Drawing.Point($e.X, $e.Y)
            }
        })
    # マウスが動いているとき
    $target.Add_MouseMove({
            param($_sender, $e)
            if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Left -and !$script:mousePoint.IsEmpty) {
                # マウスの位置を取得して移動させる
                $currentScreenPos = [System.Windows.Forms.Cursor]::Position
                $form.Location = New-Object System.Drawing.Point(
                    ($currentScreenPos.X - $script:mousePoint.X),
                    ($currentScreenPos.Y - $script:mousePoint.Y)
                )

            }
        })
    # マウスボタンが離された時
    $target.Add_MouseUp({
            $script:mousePoint = [System.Drawing.Point]::Empty
        })
}

#####################
# デバッグ用機能
#####################
# $form.BackColor = [System.Drawing.Color]::Green
# $container.BackColor = [System.Drawing.Color]::Blue
# $timeLabel.BackColor = [System.Drawing.Color]::Red
$esc = New-Object System.Windows.Forms.Timer
$esc.Interval = 2000
$esc.Add_Tick({
        [System.Windows.Forms.SendKeys]::SendWait("{ESC}")
        Write-Host "Escキー送信"
    })
if ($Debug) {
    $esc.start()
    $form.BackColor = [System.Drawing.Color]::Yellow
}

#####################
# フォーム終了時
#####################
$form.Add_FormClosing({
        $timer.Stop()
        $timer.Dispose()
        $esc.Stop()
        $esc.Dispose()
    })

#####################
# イベントループの開始
#####################
[System.Windows.Forms.Application]::Run($form)