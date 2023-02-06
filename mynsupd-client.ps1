# Dynamic hostname update client for Powershell

$updatepw = 'Paste password here'
$dynhostname = 'dyn-host-name'
$updurl = 'https://dyn.domain.com/cgi-bin/mynsupd.cgi'
$ipaddr1 = (Invoke-WebRequest https://dyn.domain.com/checkip.php).Content.Trim()
$ipaddr2 = (resolve-dnsname -type A $dynhost).IPAddress

if ( $ipaddr1 -ne $ipaddr2 )
{
$Body = @{
	'updatepw'=$updatepw
	'dynhostname'=$dynhostname
	'hostip'=$ipaddr1
}

Invoke-WebRequest -Method 'POST' -Uri $updurl -Body $body
}
