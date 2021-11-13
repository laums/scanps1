# scanps1
``` command direct
powershell.exe -NoExit "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/laums/scanps1/main/scan.ps1')"
```

``` command encoded
powershell.exe -NoExit "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex(New-Object Net.WebClient).DownloadString($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAHIAYQB3AC4AZwBpAHQAaAB1AGIAdQBzAGUAcgBjAG8AbgB0AGUAbgB0AC4AYwBvAG0ALwBsAGEAdQBtAHMALwBzAGMAYQBuAHAAcwAxAC8AbQBhAGkAbgAvAHMAYwBhAG4ALgBwAHMAMQA='))))"
```
