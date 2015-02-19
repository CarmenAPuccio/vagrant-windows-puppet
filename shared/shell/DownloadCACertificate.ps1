$cacertPath = 'C:\Certificates\cacert.pem'

# This below snippet is to support librarian-puppet and SSL requests. Without it you get the following error:
# Replacing Puppet Forge API URL to use v3 https://forgeapi.puppetlabs.com. You should update your Puppetfile C:/Program Files/Puppet
# Labs/Puppet/sys/ruby/lib/ruby/2.0.0/net/http.rb:918:in `connect': SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify 
# failed (Faraday::SSLError)

if (Test-Path $cacertPath)
{
    Write-Host "$cacertPath exits"
}

else
{
    Write-Host "$cacertPath doesn't exist."
    try
    {
        New-Item -Path C:\Certificates -ItemType Directory
        Invoke-WebRequest http://curl.haxx.se/ca/cacert.pem -OutFile $cacertPath
        [Environment]::SetEnvironmentVariable("SSL_CERT_FILE", $cacertPath, "Machine")
    }
    catch [System.Exception]
    {
        Write-Host $_.Exception.ToString()
    }
}