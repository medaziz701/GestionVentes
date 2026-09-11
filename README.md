# GestionVentes - Tunisie Telecom

> Application de gestion des ventes et des objectifs commerciaux pour Tunisie Telecom, permettant le suivi des performances, le téléchargement de données Excel et la définition d'objectifs par catégorie.



## 🚀 Stack technique

![Django](https://img.shields.io/badge/Django-5.0.6-092E20?style=flat-square&logo=django&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12.7-3776AB?style=flat-square&logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-3.2.1-336791?style=flat-square&logo=postgresql&logoColor=white)
![Gunicorn](https://img.shields.io/badge/Gunicorn-21.2.0-499848?style=flat-square&logo=gunicorn&logoColor=white)
![WhiteNoise](https://img.shields.io/badge/WhiteNoise-6.6.0-FFFFFF?style=flat-square)

## 📋 Prérequis

- Python 3.12.7 ou supérieur
- pip (gestionnaire de paquets Python)
- PostgreSQL (optionnel, pour la production)
- Git

## ⚙️ Installation

```bash
# 1. Cloner le repo
git clone https://github.com/ton-username/GestionVentes.git
cd GestionVentes

# 2. Créer et activer l'environnement virtuel
python -m venv venv
# Sur Windows:
venv\Scripts\activate
# Sur Linux/Mac:
source venv/bin/activate

# 3. Installer les dépendances
pip install -r requirements.txt

# 4. Configurer les variables d'environnement
cp .env.example .env
# Remplis les valeurs dans .env (SECRET_KEY est obligatoire)

# 5. Exécuter les migrations
cd tunisie_telecom
python manage.py migrate

# 6. Créer un superutilisateur (administrateur initial)
python manage.py createsuperuser

# 7. Lancer le projet en développement
python manage.py runserver
```

L'application sera accessible sur `http://127.0.0.1:8000`

## ✨ Fonctionnalités

- **Gestion des utilisateurs** : Inscription administrateur et utilisateur avec système de confirmation
- **Téléchargement Excel** : Import de fichiers Excel contenant les données de ventes
- **Définition d'objectifs** : Création et modification d'objectifs de vente par catégorie et par mois
- **Dashboard** : Visualisation des résultats et taux de réalisation des objectifs
- **Suivi mensuel** : Affichage des données de ventes organisées par mois
- **Gestion des catégories** : Catégorisation automatique des produits
- **Suppression de données** : Suppression par mois des données de ventes
- **Interface responsive** : Design adapté pour différents écrans

## 🌐 Démo live

En cours de déploiement

## 👤 Auteur

**Mohamed Aziz Chaabani**  
Portfolio : https://portfolio-chaabeni-mohamed-aziz.netlify.app  
GitHub : https://github.com/ton-username

## 📝 Structure du projet

```
GestionVentes-main/
├── tunisie_telecom/          # Projet Django principal
│   ├── tunisie_telecom/      # Configuration du projet
│   │   ├── settings.py       # Paramètres Django
│   │   ├── urls.py           # URLs principales
│   │   └── wsgi.py           # WSGI config
│   ├── myapp/                # Application principale
│   │   ├── models.py         # Modèles de données
│   │   ├── views.py          # Vues et logique métier
│   │   ├── forms.py          # Formulaires
│   │   ├── urls.py           # URLs de l'application
│   │   ├── utils.py          # Fonctions utilitaires
│   │   ├── templates/        # Templates HTML
│   │   └── static/           # Fichiers statiques
│   ├── manage.py             # Script de gestion Django
│   └── requirements.txt      # Dépendances Python
├── .env.example              # Exemple de variables d'environnement
├── .gitignore                # Fichiers ignorés par Git
├── Procfile                  # Configuration pour déploiement
└── runtime.txt               # Version Python requise
```

## 🔐 Sécurité

- Le fichier `.env` n'est jamais commité dans le repository
- Les mots de passe sont hachés avec Django
- Le `SECRET_KEY` doit être configuré via variable d'environnement
- Utilisation de `ALLOWED_HOSTS` pour restreindre les hôtes autorisés

## 🚀 Déploiement

Ce projet est configuré pour être déployé sur Render.com avec le fichier `Procfile` fourni.

Pour un déploiement sur une autre plateforme, assurez-vous de :
1. Configurer les variables d'environnement (SECRET_KEY, DATABASE_URL)
2. Exécuter les migrations
3. Configurer les fichiers statiques avec WhiteNoise
4. Utiliser Gunicorn comme serveur WSGI
