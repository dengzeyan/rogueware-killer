<#
.SYNOPSIS  
let malwares invade your PC now. →_→

.DESCRIPTION
if you regret it ,  run this script . 

.EXAMPLE
.\Restore-Status.ps1 (runas admin)

.NOTES
author:Vizo
date:  2017/3/1

.LINK
source project:https://liwei2.com/2015/11/27/378.html
latest project:https://github.com/vizogood/Kill-Malware
#>

# check for permissions
$currentWi = [Security.Principal.WindowsIdentity]::GetCurrent()
$currentWp = [Security.Principal.WindowsPrincipal]$currentWi
if( -not $currentWp.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    $boundPara = ($MyInvocation.BoundParameters.Keys | foreach{
        '-{0} {1}' -f  $_ ,$MyInvocation.BoundParameters[$_]} ) -join ' '
    $currentFile = (Resolve-Path  $MyInvocation.InvocationName).Path
    $fullPara = $boundPara + ' ' + $args -join ' '
    Start-Process "$psHome\powershell.exe"   -ArgumentList "$currentFile $fullPara" -verb runas
    return
}

$PSScriptRoot
$program = "C:\Program Files"
$programx86 = "C:\Program Files (x86)"
$appdata = Get-Childitem env:APPDATA | %{ $_.Value } 

# set directory permissions
# unblock Baidu
cacls "$program\Baidu\BaiduAn" /E /G Everyone:F
cacls "$program\Baidu\BaiduSd" /E /G Everyone:F
Remove-Item "$program\Baidu" -Recurse
cacls "$appdata\Baidu" /E /G Everyone:F
Remove-Item "$appdata\Baidu" -Recurse
cacls "$programx86\Baidu\BaiduAn" /E /G Everyone:F
cacls "$programx86\Baidu\BaiduSd" /E /G Everyone:F
Remove-Item "$programx86\Baidu" -Recurse
for($i = 1;$i -le 9;$i++ ){
     for($j = 0;$j -le 9; $j++ ){
         cacls "$program\BaiduSd$i.$j" /E /G Everyone:F 
         attrib -s -h "$program\BaiduSd$i.$j"
         Remove-Item "$program\BaiduSd$i.$j" -Recurse
     }
}
for($i = 1;$i -le 9;$i++ ){
     for($j = 0;$j -le 9; $j++ ){
         cacls "$programx86\BaiduSd$i.$j" /E /G Everyone:F
         attrib -s -h "$programx86\BaiduSd$i.$j" 
         Remove-Item "$programx86\BaiduSd$i.$j" -Recurse
     }
}

# unblock QiHoo 360
cacls "$program\360\360safe" /E /G Everyone:F
cacls "$program\360\360sd" /E /G Everyone:F
Remove-Item "$program\360" -Recurse
cacls "%ProgramFiles(x86)%\360\360safe" /E /G Everyone:F
cacls "%ProgramFiles(x86)%\360\360sd" /E /G Everyone:F
Remove-Item "$programx86\360" -Recurse

# Kingsoft
cacls "$program\ksafe" /E /G Everyone:F
Remove-Item "$program\ksafe" -Recurse
cacls "$program\kingsoft\kingsoft antivirus" /E /G Everyone:F
Remove-Item "$program\kingsoft" -Recurse
cacls "$programx86\ksafe" /E /G Everyone:F
Remove-Item "$programx86\ksafe" -Recurse
cacls "$programx86\kingsoft\kingsoft antivirus" /E /G Everyone:F
Remove-Item "$programx86\kingsoft" -Recurse

# Tencent
cacls "$program\Tencent\QQPCMgr" /E /G Everyone:F
Remove-Item "$program\Tencent" -Recurse
cacls "$appdata\Tencent\QQPCMgr" /E /G Everyone:F
Remove-Item "$appdata\Tencent" -Recurse
cacls "$programx86\Tencent\QQPCMgr" /E /G Everyone:F
Remove-Item "$programx86\Tencent" -Recurse

# Rising
cacls "$program\Rising" /E /G Everyone:F
cacls "$program\Rising\Rav" /E /G Everyone:F
Remove-Item "$program\Rising" -Recurse
cacls "$programx86\Rising" /E /G Everyone:F
cacls "$programx86\Rising\Rav" /E /G Everyone:F
Remove-Item "$programx86\Rising" -Recurse

Write-Host "`n"
Write-Host "已解除malware系列软件的目录权限..." -ForegroundColor Green

# unblock IP and URLs
"127.0.0.1 localhost" | Out-File "C:\Windows\System32\drivers\etc\hosts" -Force
Write-Host "`n"
Write-Host "已恢复Hosts" -ForegroundColor Green

# clear untrusted certificates
Remove-Item  "HKCU:Software\Microsoft\SystemCertificates\Disallowed\Certificates" -Recurse
Write-Host "`n"
Write-Host "已解除证书限制" -ForegroundColor Green

Write-Host "`n"
Write-Host "全部恢复! 按下任意键退出" -ForegroundColor Green
[Console]::Readkey() | Out-Null ;