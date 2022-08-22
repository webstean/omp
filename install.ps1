
# Install Cascadia Code Font - Determine current version and download
$cascadiaFont = "CascadiaPL.ttf"
$cascadiaReleasesURL = "https://github.com/microsoft/cascadia-code/releases"
$cascadiaReleases = Invoke-WebRequest -Uri $cascadiaReleasesURL
$cascadiaPath = "https://github.com" + ($cascadiaReleases.Links.href | Where-Object { $_ -match "($cascadiaFont)" } | Select-Object -First 1)
$cascadiaFile = New-TemporaryFile
# Download Cascadia Code
Invoke-WebRequest -Uri $cascadiaPath -OutFile $cascadiaFile

# Install Cascadia Code font
$fontShellApp = New-Object -Com Shell.Application
$fontShellNamespace = (New-Object -ComObject Shell.Application).Namespace(0x14)
$fontShellNamespace.CopyHere($cascadiaFile, 0x10)

# Install Oh My Posh
winget install JanDeDobbeleer.OhMyPosh -s winget --silent 

# Upgrade Oh My Posh
winget upgrade JanDeDobbeleer.OhMyPosh -s winget --silent

# Reload environment - so we can find it
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","User")

# Install fonts - needs admin
oh-my-posh font install CascadiaCode

# Themese can be found at: https://ohmyposh.dev/docs/themes
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression

oh-my-posh prompt print primary
oh-my-posh prompt print secondary




