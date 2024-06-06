<#PSScriptInfo
.VERSION 1.0
.AUTHOR Wesley
#>

#E-mail Parameters / Can be Changed
$status = "Down"
$company = "JelgCraft"
$server = "AMS-01"
$time = Get-Date
$cause = "Power Outage"
$last_change= "No last Change"
$color = "green"

if ($status -eq "Down"){
    $color = "red"
}

#Password
$username = ""
$topsecret = "" #never store passwords like this.
$password = ConvertTo-SecureString $topsecret -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

#SMTP Settings
$smtp = ""
$port = 

#Address
$to = "" # aanpassen!
$from = ""

#Message
$subject = "Storing op server: $company" 
$html = Get-Content -Path mail.html
$html1 = $html -replace ("%company", $company)
$html2 = $html1 -replace ("%status", $status)
$html3 = $html2 -replace ("%server", $server)
$html4 = $html3 -replace ("%time", $time)
$html5 = $html4 -replace ("%cause", $cause)
$html6 = $html5 -replace ("%last_change", $last_change)
$html7 = $html6 -replace ("%color", $color)


#Send MailMessage
Send-MailMessage -Body ($html7 | Out-String) -BodyAsHtml -To $to -Subject $subject -SmtpServer $smtp -From $from -Credential $psCred -Port $port
