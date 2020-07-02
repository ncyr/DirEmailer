$from = "from@email.com"
$sendFolder = "send\" #change as needed
$mailto ="email\emailto.txt" #change as needed
$username = "your@email.com"
$pass = "yourpassword" 
$smtpServer = "your-smtp-server-address"

$to = Get-Content -Path "$mailto"
$smtp = new-object Net.Mail.SmtpClient($smtpServer) 
$smtp.EnableSsl = $true
$smtp.Port = 587
$msg = new-object Net.Mail.MailMessage 
Foreach($row in $to){
    $msg.To.Add("$row");
}
$msg.From = "$from"
$msg.BodyEncoding = [system.Text.Encoding]::Unicode 
$msg.SubjectEncoding = [system.Text.Encoding]::Unicode 
$msg.IsBodyHTML = $true  
$msg.Subject = "Scheduled E-mail Attachment" 
$msg.Body = "<h2> Here are your daily Report attachments. Thanks! </h2><br><br>Please do not respond to this e-mail, no one will respond." 
$items = Get-ChildItem -Path "$sendFolder" -Name
Foreach($item in $items){
	$path = $sendFolder + $item
	$attach = new-object Net.Mail.Attachment($path)
	$msg.Attachments.Add($attach)
} 
$smtp.Credentials = New-Object System.Net.NetworkCredential("$username", "$pass"); 
$smtp.Send($msg)