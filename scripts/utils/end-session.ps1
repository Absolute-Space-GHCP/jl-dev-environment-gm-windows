<#
.SYNOPSIS
    End-of-Session Wrap-up Script
.DESCRIPTION
    Standard sequence to complete at the end of every development session.
.NOTES
    Version: 1.0.0
    Date: 2026-01-09
#>

param(
    [string]$SessionTitle = "",
    [string]$SessionSummary = "",
    [switch]$SkipPush,
    [switch]$Help
)

if ($Help) {
    Write-Host "END-SESSION WRAP-UP SCRIPT"
    Write-Host "=========================="
    Write-Host ""
    Write-Host "Usage: .\end-session.ps1 [-SessionTitle 'title'] [-SessionSummary 'summary'] [-SkipPush]"
    Write-Host ""
    Write-Host "Steps performed:"
    Write-Host "  1. Git status check"
    Write-Host "  2. Stage and commit changes"
    Write-Host "  3. Push to remotes"
    Write-Host "  4. Save session to claude-mem"
    Write-Host "  5. Display session summary"
    exit 0
}

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "=== END OF SESSION WRAP-UP ===" -ForegroundColor Magenta
Write-Host "    $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor Gray
Write-Host ""

# Step 1: Git Status
Write-Host "[1/5] Checking git status..." -ForegroundColor Cyan
$status = git status --porcelain
if ($status) {
    Write-Host "  Modified files:" -ForegroundColor Yellow
    $status | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }
    
    # Step 2: Commit changes
    Write-Host ""
    Write-Host "[2/5] Staging and committing changes..." -ForegroundColor Cyan
    
    if (-not $SessionTitle) {
        $SessionTitle = Read-Host "  Enter commit message (or press Enter for default)"
        if (-not $SessionTitle) {
            $SessionTitle = "session: End of session $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
        }
    }
    
    git add -A
    git commit -m $SessionTitle
    Write-Host "  Done!" -ForegroundColor Green
}
else {
    Write-Host "  Working tree clean" -ForegroundColor Green
    Write-Host ""
    Write-Host "[2/5] Skipping commit (no changes)" -ForegroundColor Cyan
}

# Step 3: Push to remotes
Write-Host ""
Write-Host "[3/5] Pushing to remotes..." -ForegroundColor Cyan
if (-not $SkipPush) {
    $remotes = git remote
    foreach ($remote in $remotes) {
        Write-Host "  Pushing to $remote..." -ForegroundColor Gray
        git push $remote main 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  Pushed to $remote" -ForegroundColor Green
        }
        else {
            Write-Host "  Could not push to $remote (may need workflow scope)" -ForegroundColor Yellow
        }
    }
}
else {
    Write-Host "  Skipped (-SkipPush)" -ForegroundColor Yellow
}

# Step 4: Save to claude-mem
Write-Host ""
Write-Host "[4/5] Saving session to claude-mem..." -ForegroundColor Cyan
if (-not $SessionSummary) {
    $SessionSummary = Read-Host "  Brief session summary (or press Enter to skip)"
}

if ($SessionSummary) {
    $date = Get-Date -Format "yyyy-MM-dd"
    $project = Split-Path -Leaf (Get-Location)
    $memoryPrompt = "Store this session memory to claude-mem: Title='$SessionTitle' Date=$date Project=$project Summary='$SessionSummary'. Confirm stored in under 10 words."
    $result = claude -p $memoryPrompt 2>$null
    Write-Host "  $result" -ForegroundColor Green
}
else {
    Write-Host "  Skipped" -ForegroundColor Yellow
}

# Step 5: Session Summary
Write-Host ""
Write-Host "[5/5] Session Summary" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Date:    $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor White
Write-Host "  Project: $(Split-Path -Leaf (Get-Location))" -ForegroundColor White
Write-Host "  Title:   $SessionTitle" -ForegroundColor White
Write-Host ""
Write-Host "=== SESSION COMPLETE ===" -ForegroundColor Green
Write-Host ""
