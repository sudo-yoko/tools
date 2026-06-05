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
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle

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

# 確認用
#$form.BackColor = [System.Drawing.Color]::Green
#$container.BackColor = [System.Drawing.Color]::Blue
#$timeLabel.BackColor = [System.Drawing.Color]::Red

# 起動時に時刻を表示
function Update-Time {
    $timeLabel.Text = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}
Update-Time 

# 1秒ごとに時刻を更新
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
        Update-Time
    })
$timer.Start()

# 閉じるボタン押下時
$closeButton.Add_Click({
        $form.Close();
    })

# フォーム終了時
$form.Add_FormClosing({
        $timer.Stop()
        $timer.Dispose()
    })

[System.Windows.Forms.Application]::Run($form)