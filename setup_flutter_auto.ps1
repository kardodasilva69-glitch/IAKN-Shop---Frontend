# PowerShell script to download, finalize Flutter SDK installation and run pub get
$ErrorActionPreference = "Continue"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   FLUTTER SDK INSTALLATION & SETUP      " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$zipPath = "C:\src\flutter_windows.zip"
$extractPath = "C:\src"
$flutterBin = "C:\src\flutter\bin"
$url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.47.7-stable.zip"
$targetSize = 1934624561

# Step 1: Resilient Download Loop
Write-Host "[1/5] Mengunduh/Melanjutkan unduhan Flutter SDK (1.84 GB)..." -ForegroundColor Yellow
while ($true) {
    $curSize = 0
    if (Test-Path $zipPath) {
        $curSize = (Get-Item $zipPath).Length
        $curSizeMB = [math]::Round($curSize / 1MB, 2)
        Write-Host "Ukuran saat ini: $curSizeMB MB / 1845 MB" -ForegroundColor Gray
        if ($curSize -ge $targetSize) {
            Write-Host "Arsip Flutter lengkap!" -ForegroundColor Green
            break
        }
    }
    
    & curl.exe -C - -L --retry 20 --retry-delay 5 --retry-all-errors -o $zipPath $url
    
    if (Test-Path $zipPath) {
        $curSize = (Get-Item $zipPath).Length
        if ($curSize -ge $targetSize) {
            Write-Host "Unduhan selesai!" -ForegroundColor Green
            break
        }
    }
    Write-Host "Koneksi terputus sesaat, mencoba melanjutkan kembali..." -ForegroundColor Yellow
    Start-Sleep -Seconds 3
}

# Step 2: Extracting
Write-Host "[2/5] Mengekstrak Flutter SDK ke C:\src\flutter (proses ini memerlukan 2-3 menit)..." -ForegroundColor Yellow
if (Test-Path $zipPath) {
    & tar.exe -xf $zipPath -C $extractPath
    Write-Host "Ekstraksi selesai!" -ForegroundColor Green
    Remove-Item -Force $zipPath -ErrorAction SilentlyContinue
}

# Step 3: Configure Git safe directory & PATH
Write-Host "[3/5] Mengonfigurasi PATH dan Git..." -ForegroundColor Yellow
& "C:\src\mingit\cmd\git.exe" config --global --add safe.directory "C:/src/flutter"
& "C:\src\mingit\cmd\git.exe" config --global --add safe.directory "*"

$userPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*C:\src\flutter\bin*") {
    [System.Environment]::SetEnvironmentVariable("Path", "$userPath;C:\src\flutter\bin", "User")
    Write-Host "C:\src\flutter\bin berhasil ditambahkan ke PATH User!" -ForegroundColor Green
}
$env:Path = "$env:Path;C:\src\flutter\bin;C:\src\mingit\cmd"

# Step 4: Run Flutter Doctor & enable web
Write-Host "[4/5] Menginisialisasi Flutter SDK..." -ForegroundColor Yellow
& "$flutterBin\flutter.bat" config --no-analytics
& "$flutterBin\flutter.bat" config --enable-web
& "$flutterBin\flutter.bat" doctor

# Step 5: Pub get in app-commerce
Write-Host "[5/5] Menjalankan flutter pub get di app-commerce..." -ForegroundColor Yellow
Set-Location "c:\Users\DESKTOP\Downloads\app-commerce"
& "$flutterBin\flutter.bat" pub get

Write-Host "==========================================" -ForegroundColor Green
Write-Host "   FLUTTER SIAP DIGUNAKAN!               " -ForegroundColor Green
Write-Host "Jalankan perintah berikut di folder project:" -ForegroundColor White
Write-Host "  flutter run -d chrome" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Green
