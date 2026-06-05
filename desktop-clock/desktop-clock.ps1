Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# フォームの作成
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(420, 80);
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.TopMost = $true
$form.Opacity = 0.9

# 閉じるボタン
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Font = New-Object System.Drawing.Font("Arial", 20)
$closeButton.Text = "×"
$closeButton.Width = 70
$closeButton.Dock = [System.Windows.Forms.DockStyle]::Right
$closeButton.Add_Click({
        $form.Close();
    })
$form.Controls.Add($closeButton)

# 時計のラベル
$timeLabel = New-Object System.Windows.Forms.Label
$timeLabel.Font = New-Object System.Drawing.Font("Arial", 20)
$timeLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
$timeLabel.Dock = [System.Windows.Forms.DockStyle]::Fill
$timeLabel.Text = " " + (Get-Date).ToString("yyyy-MM-dd HH:mm:ss.fff")
# $timeLabel.BackColor = [System.Drawing.Color]::Red
$form.Controls.Add($timeLabel)




[System.Windows.Forms.Application]::Run($form)