$access_token = (ConvertFrom-SecureString (Get-AzAccessToken -ResourceUrl https://management.azure.com -AsSecureString).Token -AsPlainText)
Write-Output $access_token
