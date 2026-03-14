# ─────────────────────────────────────────────
#  IBKR Eval Tool — Environment Setup
#  Run once from the ibkr_eval folder:
#    .\setup.ps1
# ─────────────────────────────────────────────

$ErrorActionPreference = "Stop"
$VenvDir = ".venv"

Write-Host "`n  pygame snake — Setup" -ForegroundColor Cyan
Write-Host "  ─────────────────────────────────────" -ForegroundColor DarkGray

# ── Check Python is available ──────────────────────────────────────────
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Error "Python not found. Please install Python 3.10+ and ensure it is on your PATH."
    exit 1
}

$pyVersion = python --version 2>&1
Write-Host "  Python : $pyVersion" -ForegroundColor Gray

# ── Create virtual environment ─────────────────────────────────────────
if (Test-Path $VenvDir) {
    Write-Host "  Venv   : '$VenvDir' already exists — skipping creation." -ForegroundColor Yellow
} else {
    Write-Host "  Venv   : Creating '$VenvDir'..." -ForegroundColor Gray
    python -m venv $VenvDir
    Write-Host "  Venv   : Created." -ForegroundColor Green
}

# ── Resolve activate script ────────────────────────────────────────────
$Activate = Join-Path $VenvDir "Scripts\Activate.ps1"
if (-not (Test-Path $Activate)) {
    Write-Error "Could not find '$Activate'. Virtual environment may be corrupt — delete '$VenvDir' and re-run."
    exit 1
}

# ── Activate and install ───────────────────────────────────────────────
Write-Host "  Pip    : Installing packages from requirements.txt..." -ForegroundColor Gray
& $Activate

python -m pip install --upgrade pip --quiet
pip install -r requirements.txt

Write-Host "`n  Setup complete." -ForegroundColor Green
Write-Host "  To start the tool:" -ForegroundColor Cyan
Write-Host "    1. Activate the venv :  .\.venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "    2. Launch the server  :  python main.py" -ForegroundColor White
Write-Host ""
conda deactivate