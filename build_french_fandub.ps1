# KH2FM French Final Mix Voices Builder
# Rebuilds the compatibility patch from the two original community patches.
# No game ISO or BIOS is read or distributed.

$ErrorActionPreference = "Stop"

$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$FrenchPath = Join-Path $BaseDir "FANDUB[1_0].kh2patch"
$TranslationPath = Join-Path $BaseDir "1. Translation.kh2patch"
$OutputPath = Join-Path $BaseDir "FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch"

$ExpectedFrenchMD5 = "02D114FD8C773BA9AB5473198DE73470"
$ExpectedOutputMD5 = "73F43F66828453456946D9E9CFCE3F72"

function Fail([string]$Message) {
    Write-Host ""
    Write-Host "ERROR: $Message" -ForegroundColor Red
    exit 1
}

function Get-MD5([string]$Path) {
    return (Get-FileHash -Algorithm MD5 -Path $Path).Hash.ToUpperInvariant()
}

function Read-U32([byte[]]$Data, [int]$Offset) {
    return [BitConverter]::ToUInt32($Data, $Offset)
}

function Write-U32([byte[]]$Data, [int]$Offset, [uint32]$Value) {
    $b = [BitConverter]::GetBytes($Value)
    [Array]::Copy($b, 0, $Data, $Offset, 4)
}

function Parse-Patch([byte[]]$Data) {
    if ($Data.Length -lt 16) { Fail "Patch file is too small." }

    $magic = Read-U32 $Data 0
    $fileCountOffset = [int](Read-U32 $Data 8)

    if ($fileCountOffset -lt 0 -or ($fileCountOffset + 4) -gt $Data.Length) {
        Fail "Invalid file-count offset in patch."
    }

    $count = [int](Read-U32 $Data $fileCountOffset)
    $entries = New-Object System.Collections.Generic.List[object]
    $pos = $fileCountOffset + 4

    for ($i = 0; $i -lt $count; $i++) {
        if (($pos + 92) -gt $Data.Length) { Fail "Truncated patch entry table." }

        $raw = New-Object byte[] 92
        [Array]::Copy($Data, $pos, $raw, 0, 92)

        $entry = [PSCustomObject]@{
            Hash       = [uint32](Read-U32 $Data ($pos + 0))
            Offset     = [uint32](Read-U32 $Data ($pos + 4))
            CSize      = [uint32](Read-U32 $Data ($pos + 8))
            USize      = [uint32](Read-U32 $Data ($pos + 12))
            Parent     = [uint32](Read-U32 $Data ($pos + 16))
            Relink     = [uint32](Read-U32 $Data ($pos + 20))
            Compressed = [uint32](Read-U32 $Data ($pos + 24))
            IsNew      = [uint32](Read-U32 $Data ($pos + 28))
            Raw        = $raw
        }

        if (([uint64]$entry.Offset + [uint64]$entry.CSize) -gt [uint64]$Data.Length) {
            Fail ("Payload outside patch for entry hash 0x{0:X8}." -f $entry.Hash)
        }

        $entries.Add($entry)
        $pos += 92
    }

    return [PSCustomObject]@{
        Magic = $magic
        FileCountOffset = $fileCountOffset
        Entries = $entries
    }
}

Write-Host ""
Write-Host "KH2FM French Final Mix Voices Builder" -ForegroundColor Cyan
Write-Host "-------------------------------------"

if (-not (Test-Path -LiteralPath $FrenchPath)) {
    Fail "Missing FANDUB[1_0].kh2patch"
}
if (-not (Test-Path -LiteralPath $TranslationPath)) {
    Fail "Missing 1. Translation.kh2patch"
}

$frenchMD5 = Get-MD5 $FrenchPath
Write-Host "French FANDUB MD5: $frenchMD5"
if ($frenchMD5 -ne $ExpectedFrenchMD5) {
    Fail "Unexpected FANDUB[1_0].kh2patch version. Expected MD5 $ExpectedFrenchMD5"
}

$frenchData = [IO.File]::ReadAllBytes($FrenchPath)
$translationEncrypted = [IO.File]::ReadAllBytes($TranslationPath)

# Xeeynamo/CrazyCatz00 patch decryption used by the original toolkit format.
$key = [byte[]](0x58,0x0C,0xDD,0x59,0xF7,0x24,0x7F,0x4F)
$translationData = New-Object byte[] $translationEncrypted.Length
[Array]::Copy($translationEncrypted, $translationData, $translationEncrypted.Length)

$remaining = $translationData.Length
for ($i = 0; $i -lt $translationData.Length; $i++) {
    $remaining--
    $translationData[$i] = $translationData[$i] -bxor $key[$remaining -band 7]
}

$fr = Parse-Patch $frenchData
$en = Parse-Patch $translationData

# "KH2P" little-endian = 0x5032484B
if ($fr.Magic -ne 0x5032484B) {
    Fail "French patch does not have a valid KH2P header."
}
if (($en.Magic -ne 0x5032484B) -and ($en.Magic -ne 0x5132484B) -and ($en.Magic -ne 0x4632484B)) {
    Fail "Translation patch did not decrypt to a supported KH2 patch header."
}

$frByHash = @{}
foreach ($e in $fr.Entries) {
    if ($e.IsNew -eq 1) {
        $frByHash[[string]$e.Hash] = $e
    }
}

$matches = New-Object System.Collections.Generic.List[object]
foreach ($enEntry in $en.Entries) {
    $k = [string]$enEntry.Hash
    if ($frByHash.ContainsKey($k)) {
        $matches.Add([PSCustomObject]@{
            En = $enEntry
            Fr = $frByHash[$k]
        })
    }
}

if ($matches.Count -ne 165) {
    Fail "Expected 165 matching French voice entries, found $($matches.Count). Check that both source patches are the expected versions."
}

Write-Host "Matched French voice entries: 165" -ForegroundColor Green

$fileCountOffset = $en.FileCountOffset

$header = New-Object byte[] $fileCountOffset
[Array]::Copy($translationData, 0, $header, 0, $fileCountOffset)

$tableSize = 4 + (92 * $matches.Count)
$payloadOffset = [uint32]($fileCountOffset + $tableSize)

$ms = New-Object IO.MemoryStream
$bw = New-Object IO.BinaryWriter($ms)

$bw.Write($header)
$bw.Write([uint32]$matches.Count)

$current = [uint32]$payloadOffset
$payloads = New-Object System.Collections.Generic.List[byte[]]

foreach ($m in $matches) {
    $raw = New-Object byte[] 92
    [Array]::Copy($m.En.Raw, $raw, 92)

    Write-U32 $raw 4  $current
    Write-U32 $raw 8  ([uint32]$m.Fr.CSize)
    Write-U32 $raw 12 ([uint32]$m.Fr.USize)
    Write-U32 $raw 24 ([uint32]$m.Fr.Compressed)

    $bw.Write($raw)

    $payload = New-Object byte[] ([int]$m.Fr.CSize)
    [Array]::Copy($frenchData, [int]$m.Fr.Offset, $payload, 0, [int]$m.Fr.CSize)
    $payloads.Add($payload)

    $current = [uint32]($current + [uint32]$payload.Length)
}

foreach ($payload in $payloads) {
    $bw.Write($payload)
}

$bw.Flush()
[IO.File]::WriteAllBytes($OutputPath, $ms.ToArray())
$bw.Dispose()
$ms.Dispose()

$outMD5 = Get-MD5 $OutputPath
Write-Host "Output MD5: $outMD5"

if ($outMD5 -ne $ExpectedOutputMD5) {
    Fail "Output was generated but its MD5 differs from the known-good experimental build. Expected $ExpectedOutputMD5"
}

Write-Host ""
Write-Host "SUCCESS" -ForegroundColor Green
Write-Host "Created:"
Write-Host "  $OutputPath"
Write-Host ""
Write-Host "Known-good experimental MD5:"
Write-Host "  $ExpectedOutputMD5"
Write-Host ""
Write-Host "Reminder: only one Final Mix-exclusive cutscene has been manually confirmed so far."
