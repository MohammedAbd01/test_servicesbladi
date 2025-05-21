@echo off
echo ===== Script de réinitialisation complète du projet ServicesBladi =====
echo Ce script va nettoyer tous les caches et réinstaller les dépendances
echo.

:: Arrêter les services XAMPP si actifs
echo Arrêt des services XAMPP...
taskkill /F /IM mysqld.exe 2>NUL
taskkill /F /IM httpd.exe 2>NUL
timeout /t 3 /nobreak > NUL

:: Définir les chemins (ajustez selon votre configuration)
set VENV=venv
set PYTHON=%VENV%\Scripts\python
set PIP=%VENV%\Scripts\pip

:: Suppression de tous les fichiers __pycache__ et .pyc
echo Suppression des fichiers cache Python...
for /d /r . %%d in (__pycache__) do @if exist "%%d" rd /s /q "%%d"
del /s /q *.pyc > NUL
del /s /q *.pyo > NUL

:: Suppression des migrations (sauf __init__.py)
echo Suppression des fichiers de migration...
for /d /r . %%d in (migrations) do (
    if exist "%%d" (
        for %%f in ("%%d\*.py") do (
            if not "%%~nxf"=="__init__.py" del /q "%%f"
        )
    )
)

:: Suppression du répertoire staticfiles
echo Suppression des fichiers statiques compilés...
if exist "backend\staticfiles" rd /s /q "backend\staticfiles"

:: Recréation du virtualenv (optionnel - décommenter si besoin)
echo Voulez-vous recréer l'environnement virtuel? (o/n)
set /p recreate_venv=
if /i "%recreate_venv%"=="o" (
    echo Recréation de l'environnement virtuel...
    rd /s /q %VENV%
    python -m venv %VENV%
    call %VENV%\Scripts\activate
    %PIP% install --upgrade pip
    %PIP% install -r requirements.txt
) else (
    echo Mise à jour des dépendances...
    call %VENV%\Scripts\activate
    %PIP% install -r requirements.txt --force-reinstall
)

:: Nettoyage et recréation de la base de données
echo Voulez-vous réinitialiser la base de données? (o/n)
set /p reset_db=
if /i "%reset_db%"=="o" (
    :: Démarrer MySQL via XAMPP
    echo Démarrage de MySQL...
    start /b "" "C:\xampp\mysql\bin\mysqld"
    timeout /t 5 /nobreak > NUL
    
    :: Réinitialiser la base de données
    echo Suppression et recréation de la base de données...
    "C:\xampp\mysql\bin\mysql" -u root -e "DROP DATABASE IF EXISTS servicesbladi; CREATE DATABASE servicesbladi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    
    :: Appliquer les migrations
    echo Application des migrations...
    cd backend
    %PYTHON% manage.py makemigrations
    %PYTHON% manage.py migrate
    
    :: Créer superuser (optionnel)
    echo Voulez-vous créer un superuser? (o/n)
    set /p create_superuser=
    if /i "%create_superuser%"=="o" (
        %PYTHON% manage.py createsuperuser
    )
    
    cd ..
)

:: Générer les fichiers statiques
echo Collecte des fichiers statiques...
cd backend
%PYTHON% manage.py collectstatic --noinput
cd ..

:: Ajouter un fichier version.txt avec timestamp
echo Création d'un fichier de version...
set timestamp=%date:~6,4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set timestamp=%timestamp: =0%
echo Version: %timestamp% > frontend\static\version.txt

echo.
echo ===== Instructions pour le démarrage =====
echo 1. Démarrez XAMPP (Apache et MySQL)
echo 2. Exécutez le serveur Django avec: cd backend ^& python manage.py runserver
echo 3. Dites à vos amis de cloner le dépôt depuis zéro et d'utiliser ce script
echo.
echo Pour s'assurer que tout le monde a la même version:
echo - Vérifiez que vos amis utilisent cette version exacte: %timestamp%
echo - Assurez-vous qu'ils utilisent EXACTEMENT la même commande pour démarrer le serveur
echo.
echo ===== Fin du script =====
pause 