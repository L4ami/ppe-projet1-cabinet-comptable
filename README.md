# 🧑‍💻 Mise en service d'un poste de travail pour un cabinet comptable

![Windows 11](https://img.shields.io/badge/Windows_11_Pro-24H2-0078D4?logo=windows&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-26.04_LTS-E95420?logo=ubuntu&logoColor=white)
![CUPS](https://img.shields.io/badge/CUPS-2.4.16-4B5563)
![PowerShell](https://img.shields.io/badge/PowerShell-winget-5391FE?logo=powershell&logoColor=white)
![VMware](https://img.shields.io/badge/VMware_Workstation-Pro_17-607078?logo=vmware&logoColor=white)
![Statut](https://img.shields.io/badge/statut-termin%C3%A9-brightgreen)

> **En une phrase :** j'ai livré, prêt à l'emploi, le poste Windows 11 d'une nouvelle collaboratrice d'un cabinet comptable genevois de 3 personnes : système, comptes, réseau, logiciels métier, sécurité de base, et une vraie imprimante réseau partagée par un serveur Linux.

Ce dépôt est écrit pour être compris **même sans rien connaître** à l'administration de postes : tous les mots techniques sont expliqués.<br>
👉 Le livrable complet, étape par étape et avec les captures, est dans [`fiche-mise-en-service.md`](fiche-mise-en-service.md).

> **Projet 1/5** du PPE IT Essentials, module CFC 187 *« Mettre en service un poste de travail ICT avec le système d'exploitation »*, classe E1B, Geneva Institute of Technology (GIT), septembre 2026.

---

## ✅ Ce qui a été réalisé

| Livrable | État |
|---|---|
| Installation Windows 11 Pro 24H2 en UEFI/GPT | ✅ |
| Compte administrateur local + compte utilisateur standard | ✅ |
| Politique de mot de passe (10 caractères, verrouillage après 5 échecs) | ✅ |
| Configuration réseau : IP fixe, nom de machine, groupe de travail | ✅ |
| Logiciels métier installés et fonctionnels | ✅ |
| Imprimante réseau partagée + impression de test validée | ✅ |
| Mises à jour, antivirus et pare-feu vérifiés | ✅ |
| Fiche de mise en service | ✅ |

## 🏗️ Architecture mise en place

```
┌─────────────────────────┐         ┌──────────────────────────┐
│      COMPTA-PG          │   IPP   │        pc02-pg           │
│    192.168.190.20       │ ──────► │    192.168.190.10        │
│  Windows 11 Pro 24H2    │  :631   │  Ubuntu 26.04 + CUPS     │
│  Poste de la            │         │  Serveur d'impression    │
│  collaboratrice         │         │  → IMP-CABINET           │
└───────────┬─────────────┘         └──────────────────────────┘
            │
            ▼
   ┌──────────────────┐
   │   Passerelle     │
   │ 192.168.190.2    │
   └──────────────────┘
```

Groupe de travail : `CABINET` · Réseau : `192.168.190.0/24`

**Le choix marquant du projet :** le cabinet ne possède pas d'imprimante réseau autonome. Plutôt que de simuler l'étape, une véritable architecture client/serveur a été montée — une machine Linux joue le rôle de serveur d'impression avec CUPS et publie l'imprimante en IPP sur le réseau local. L'impression de test a réellement traversé le réseau et produit un document, vérifié des deux côtés.

## 📁 Contenu du dépôt

```
.
├── README.md                        ← ce fichier
├── fiche-mise-en-service.md         ← le livrable principal
├── scripts/
│   └── install-logiciels-metier.ps1     ← installation automatisée des logiciels
└── captures/                        ← 22 captures d'écran, numérotées chronologiquement
```

## 🛠️ Environnement technique

| Élément | Détail |
|---|---|
| Virtualisation | VMware Workstation Pro 17 |
| Poste livré | Windows 11 Pro 24H2 (build 26100), UEFI + Secure Boot + TPM 2.0 |
| Serveur d'impression | Ubuntu 26.04 LTS, CUPS 2.4.16, cups-pdf |
| Réseau | VMnet8 (NAT), `192.168.190.0/24` |
| Logiciels installés | LibreOffice, Adobe Acrobat Reader, Mozilla Firefox, 7-Zip, Mozilla Thunderbird, Crésus |
| Outil de capture | Screenpresso |

## ⚙️ Le script d'installation

`scripts/install-logiciels-metier.ps1` installe l'ensemble des logiciels bureautiques via **winget**, le gestionnaire de paquets intégré à Windows, et génère un rapport d'inventaire horodaté.

L'intérêt : l'opération est **reproductible à l'identique** sur les deux autres postes du cabinet, et le rapport documente les versions exactes livrées au client.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\install-logiciels-metier.ps1
```

> Note : le script force `--source winget`. Sans cette option, winget interroge aussi le catalogue Microsoft Store et refuse d'installer quoi que ce soit si celui-ci est injoignable.

## 🧠 Ce que ce projet m'a appris

- Un poste de travail se configure **en fonction du client**, pas en fonction de la consigne : le format régional suisse, le groupe de travail nommé d'après le cabinet et le compte sans droits administrateur découlent tous du contexte métier.
- Un diagnostic réseau se fait **par étapes** : adresse obtenue → passerelle joignable → extérieur joignable → résolution de noms. Chaque étape isole une cause différente.
- Une imprimante réseau n'est pas un périphérique branché sur un poste : c'est un **service**, hébergé par un serveur, publié sur un protocole, et protégé par un pare-feu qu'il faut ouvrir explicitement.
- Documenter, c'est prouver le résultat, pas l'intention. Une capture de la configuration ne vaut rien sans la capture de la vérification.

## 🔗 Les 5 projets du PPE IT Essentials

| Projet | Sujet | Dépôt |
|---|---|---|
| 1/5 | Poste de travail pour un cabinet comptable | **ce dépôt** |
| 2/5 | Poste multi-utilisateurs en salle informatique | [`ppe-projet2-salle-informatique`](https://github.com/L4ami/ppe-projet2-salle-informatique) |
| 3/5 | Migration et sauvegarde d'un poste | [`ppe-projet3-migration-sauvegarde`](https://github.com/L4ami/ppe-projet3-migration-sauvegarde) |
| 4/5 | Dépannage et diagnostic d'un poste en panne | [`ppe-projet4-depannage-diagnostic`](https://github.com/L4ami/ppe-projet4-depannage-diagnostic) |
| 5/5 | Déploiement standardisé d'un poste | [`ppe-projet5-deploiement-image-systeme`](https://github.com/L4ami/ppe-projet5-deploiement-image-systeme) |

---

**Auteur :** Paul Giocanti ([@L4ami](https://github.com/L4ami)) · Septembre 2026<br>
CFC d'informaticien + Bachelor (double certification) · Geneva Institute of Technology
