# Projet 1 — Poste de travail pour un cabinet comptable

> Énoncé fourni par le formateur. Reproduit ici tel quel, à titre de référence du cahier des charges.

**Cours de référence :** IT Essentials — Mettre en service un poste de travail ICT avec le système d'exploitation
**Classe :** E1B
**Niveau :** Débutant
**Durée :** 1 semaine (PPE)

## Contexte

Un petit cabinet comptable de 3 personnes vous engage pour mettre en service le poste de travail de sa nouvelle collaboratrice, prêt à l'emploi dès le lundi matin.

## Objectifs pédagogiques

- Installer un système d'exploitation sur une machine physique ou virtuelle.
- Créer un compte utilisateur standard avec une politique de mot de passe simple.
- Installer les logiciels bureautiques de base.
- Configurer l'accès à une imprimante partagée sur le réseau local.
- Appliquer les premières mesures de sécurité (mises à jour, antivirus, pare-feu).

## Consignes / Étapes

1. Installer le système d'exploitation depuis un support fourni.
2. Créer un compte administrateur local et un compte utilisateur standard.
3. Configurer le réseau (IP, nom de machine, groupe de travail).
4. Installer les logiciels métier demandés par le formateur.
5. Ajouter une imprimante réseau partagée et tester une impression.
6. Vérifier l'activation des mises à jour, de l'antivirus et du pare-feu.
7. Rédiger une fiche de mise en service.

## Livrables attendus

- Le poste opérationnel présenté au formateur.
- Une fiche de mise en service (Markdown/PDF).
- Captures d'écran des étapes clés (compte, logiciel, imprimante, mises à jour).

## Critères d'évaluation

| Critère | Pondération |
|---|---|
| Installation du système d'exploitation | 20 % |
| Configuration des comptes utilisateurs | 20 % |
| Logiciels métier installés et fonctionnels | 20 % |
| Configuration réseau et imprimante | 20 % |
| Documentation et mesures de sécurité de base | 20 % |

## Notation et évaluation

L'évaluation du projet suit le barème en vigueur à Geneva Institute of Technology (échelle suisse, note sur 6, seuil de réussite **4.0/6**).

**Formule de conversion :** `Note = 1 + (Total des points obtenus en % / 100) × 5`

| % obtenu | Note /6 (indicatif) |
|---|---|
| 40 % | 3.0 |
| 50 % | 3.5 |
| 60 % | 4.0 |
| 70 % | 4.5 |
| 80 % | 5.0 |
| 90 % | 5.5 |
| 100 % | 6.0 |

> Le barème détaillé (répartition des points par critère) est donné dans le tableau **Critères d'évaluation** ci-dessus. Le formateur référent peut ajuster la pondération pour un groupe/binôme après validation préalable auprès des étudiants.

## Ressources et sources

- [Installer Windows 11 — Microsoft Learn](https://learn.microsoft.com/fr-fr/autopilot/overview)
- [Debian — Installation](https://www.debian.org/releases/stable/installmanual)

---

### Note de l'étudiant sur les ressources

Les deux liens de la section « Ressources et sources » ne donnent pas accès aux images d'installation :

- Le premier pointe vers la documentation de **Windows Autopilot**, un service de déploiement automatisé d'entreprise (l'appareil se configure seul via Intune/Entra ID), sans rapport avec une installation manuelle et sans lien de téléchargement. Microsoft Learn est un site de documentation ; les images ISO sont distribuées sur `microsoft.com/software-download`.
- Le second est le **manuel d'installation** de Debian 13 « trixie » — un document, pas un téléchargement. Les images Debian sont sur `debian.org/CD/`.

L'installation a donc été réalisée depuis le **support fourni par le formateur**, conformément à la consigne 1 qui précise « depuis un support fourni ».
