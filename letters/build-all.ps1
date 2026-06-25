param()

$TexFiles = Get-ChildItem -Filter "*.tex" -File

foreach ($File in $TexFiles) {
    $BaseName = $File.BaseName
    Write-Host "Building $($File.Name)..."
    
    pdflatex -interaction=nonstopmode $File.FullName 2>&1 | Out-Null
    
    Remove-Item -Force "$BaseName.aux" -ErrorAction SilentlyContinue
    Remove-Item -Force "$BaseName.log" -ErrorAction SilentlyContinue
    Remove-Item -Force "$BaseName.out" -ErrorAction SilentlyContinue
    Remove-Item -Force "$BaseName.fls" -ErrorAction SilentlyContinue
    Remove-Item -Force "$BaseName.fdb_latexmk" -ErrorAction SilentlyContinue
    
    if (Test-Path "$BaseName.pdf") {
        Write-Host "  OK: $BaseName.pdf"
    }
}

Write-Host "Complete"
