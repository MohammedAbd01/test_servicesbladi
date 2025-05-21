# Instructions pour exécuter ServicesBladi correctement

## Problème identifié
Nous avons identifié un problème où vous voyez une ancienne version du site après l'ajout de Django Channels. Suivez EXACTEMENT ces instructions pour garantir que vous avez la bonne version.

## Prérequis
- XAMPP installé (avec MySQL et Apache)
- Python 3.10 ou supérieur
- Git installé
- Visual Studio Code (recommandé)

## Instructions étape par étape

### 1. Supprimer complètement le projet existant
```bash
# Ne gardez aucun code de l'ancienne version
# Supprimez complètement le dossier
```

### 2. Cloner le dépôt à nouveau à partir de zéro
```bash
git clone [URL_DU_REPO] new_services_bladi
cd new_services_bladi
```

### 3. Exécutez le script de réinitialisation
```bash
# Double-cliquez sur reset_project.bat
# OU exécutez-le depuis le terminal
reset_project.bat
```

### 4. Démarrer XAMPP correctement
- Arrêtez complètement XAMPP s'il est en cours d'exécution
- Démarrez uniquement les services Apache et MySQL
- Assurez-vous qu'ils sont en cours d'exécution (voyants verts)

### 5. Exécuter le serveur Django
```bash
cd backend
# UTILISEZ CETTE COMMANDE EXACTE - ne changez rien
python manage.py runserver
```

### 6. Accéder au site
- Ouvrez votre navigateur en mode navigation privée
- Accédez exactement à cette URL: http://127.0.0.1:8000/?v=fresh
- Vérifiez que vous voyez la dernière version

### 7. Vérification de version
- Comparez le fichier `frontend/static/version.txt`
- Assurez-vous que votre version correspond à : [INSÉRER_VERSION_ACTUELLE]

## Résolution de problèmes

Si vous voyez toujours l'ancienne version:

1. Assurez-vous de supprimer les cookies et le cache du navigateur
```
Chrome: Ctrl+Shift+Delete → sélectionnez "Tout" → Effacer les données
Edge: Ctrl+Shift+Delete → sélectionnez "Tout" → Effacer
Firefox: Ctrl+Shift+Delete → sélectionnez "Tout" → Effacer maintenant
```

2. Vérifiez les dépendances Django
```bash
# Dans le dossier du projet
pip list | findstr channel
```
Vous devriez voir:
```
channels            4.0.0
channels-redis      4.1.0
```

3. Assurez-vous que votre base de données est à jour
```bash
cd backend
python manage.py migrate
```

4. Si rien ne fonctionne, essayez cette commande supplémentaire
```bash
cd backend
python manage.py collectstatic --noinput
python manage.py runserver --noreload
```

## Notes importantes
- **N'utilisez PAS** `python manage.py runserver 0.0.0.0:8000` car cela peut causer des problèmes avec Channels
- **N'utilisez PAS** d'anciens tutoriels ou commandes
- **N'installez PAS** d'autres versions de packages

Si vous rencontrez encore des problèmes, veuillez me contacter directement. 