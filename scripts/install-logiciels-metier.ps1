<#
================================================================================
 Projet 1 - Poste de travail pour un cabinet comptable
 Installation des logiciels metier - PC-COMPTA-PG
 - PPE IT Essentials 187 - Classe E1B

 UTILISATION
   1. Ouvrir PowerShell EN TANT QU'ADMINISTRATEUR (compte adm.pg)
   2. Autoriser l'execution du script pour cette session uniquement :
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
      (Windows bloque par defaut les scripts telecharges ; cette commande leve
       le blocage uniquement pour la fenetre en cours, rien n'est modifie
       durablement sur le systeme.)
   3. Lancer :  .\install-logiciels-metier.ps1

 RESULTAT
   Un rapport texte sur le Bureau : inventaire-logiciels-PC-COMPTA-PG.txt
   A joindre en annexe de la fiche de mise en service.
================================================================================
#>

$ErrorActionPreference = 'Continue'
$rapport = Join-Path ([Environment]::GetFolderPath('Desktop')) 'inventaire-logiciels-PC-COMPTA-PG.txt'

# --- Liste des logiciels : identifiant winget + justification metier -----------
$logiciels = @(
    @{ Id = 'TheDocumentFoundation.LibreOffice'; Nom = 'LibreOffice';           Raison = 'Suite bureautique (tableur, traitement de texte) - compatible xlsx/docx' },
    @{ Id = 'Adobe.Acrobat.Reader.64-bit';       Nom = 'Adobe Acrobat Reader';  Raison = 'Lecture des factures, releves bancaires et declarations fiscales' },
    @{ Id = 'Mozilla.Firefox';                   Nom = 'Mozilla Firefox';       Raison = 'Acces aux logiciels de comptabilite en ligne et a l e-banking' },
    @{ Id = '7zip.7zip';                         Nom = '7-Zip';                 Raison = 'Ouverture des archives de pieces comptables envoyees par les clients' },
    @{ Id = 'Mozilla.Thunderbird';               Nom = 'Mozilla Thunderbird';   Raison = 'Client de messagerie du cabinet' }
)

# --- Verification prealable de winget -----------------------------------------
Write-Host "`n=== Verification de winget ===" -ForegroundColor Cyan
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget est introuvable." -ForegroundColor Red
    Write-Host "Ouvrir le Microsoft Store, chercher 'Programme d'installation d'application'"
    Write-Host "(App Installer) et le mettre a jour, puis relancer ce script."
    exit 1
}
$versionWinget = (winget --version)
Write-Host "winget detecte : $versionWinget" -ForegroundColor Green

# --- Installation --------------------------------------------------------------
$resultats = @()

foreach ($app in $logiciels) {
    Write-Host "`n--- Installation : $($app.Nom) ---" -ForegroundColor Cyan
    Write-Host "    Raison : $($app.Raison)" -ForegroundColor DarkGray

    winget install --id $($app.Id) --exact --silent --source winget `
                   --accept-package-agreements --accept-source-agreements | Out-Host

    if ($LASTEXITCODE -eq 0) {
        Write-Host "    OK - installe" -ForegroundColor Green
        $statut = 'Installe'
    }
    elseif ($LASTEXITCODE -eq -1978335135) {
        Write-Host "    Deja present sur le poste" -ForegroundColor Yellow
        $statut = 'Deja present'
    }
    else {
        Write-Host "    ECHEC (code $LASTEXITCODE) - a installer manuellement" -ForegroundColor Red
        $statut = "Echec (code $LASTEXITCODE)"
    }

    $resultats += [PSCustomObject]@{
        Logiciel    = $app.Nom
        Identifiant = $app.Id
        Statut      = $statut
        Raison      = $app.Raison
    }
}

# --- Rapport -------------------------------------------------------------------
$entete = @"
================================================================================
INVENTAIRE DES LOGICIELS METIER
================================================================================
Poste          : PC-COMPTA-PG
Client         : Cabinet comptable (3 collaborateurs)
Technicien     : Paul Giocanti
Date du releve : $(Get-Date -Format 'dd.MM.yyyy HH:mm')
Systeme        : $((Get-CimInstance Win32_OperatingSystem).Caption) - build $([Environment]::OSVersion.Version.Build)
Gestionnaire   : winget $versionWinget
================================================================================

"@

$corps = $resultats | Format-Table Logiciel, Statut, Raison -AutoSize -Wrap | Out-String

$pied = @"

--------------------------------------------------------------------------------
VERSIONS INSTALLEES (releve winget)
--------------------------------------------------------------------------------
$((winget list --source winget --accept-source-agreements | Out-String))
"@

$entete + $corps + $pied | Out-File -FilePath $rapport -Encoding UTF8

Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host " Termine. Rapport genere :" -ForegroundColor Green
Write-Host " $rapport" -ForegroundColor Green
Write-Host "================================================================`n" -ForegroundColor Cyan
Write-Host "CAPTURE a prendre maintenant : cette fenetre PowerShell avec le" -ForegroundColor Yellow
Write-Host "recapitulatif des installations -> 20-logiciels-installation.png" -ForegroundColor Yellow
