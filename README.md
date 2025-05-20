# Test ServicesBladi

This project is a Django-based web application with a backend and frontend structure. Follow the steps below to set up and run the project from scratch.

## Prerequisites
- Python 3.10 or higher
- pip (Python package manager)
- (Optional) Virtual environment tool: `venv` or `virtualenv`

## 1. Clone the Repository
Clone the project to your local machine (if not already done):
```powershell
git clone <repository-url>
cd test_servicesbladi
```

## 2. Set Up a Virtual Environment (Recommended)
```powershell
python -m venv venv
.\venv\Scripts\activate
```

## 3. Install Dependencies
Install all required Python packages:
```powershell
pip install -r requirements.txt
```

## 4. Database Setup
Navigate to the backend directory:
```powershell
cd backend
```
Run migrations to set up the database:
```powershell
python manage.py migrate
```

## 5. Create a Superuser (Admin Account)
```powershell
python manage.py createsuperuser
```
Follow the prompts to set up your admin credentials.

## 6. Collect Static Files (If Needed)
```powershell
python manage.py collectstatic
```

## 7. Run the Development Server
```powershell
python manage.py runserver
```
The server will start at `http://127.0.0.1:8000/` by default.

## 8. Access the Application
- **Frontend:** Open your browser and go to `http://127.0.0.1:8000/`
- **Admin Panel:** Go to `http://127.0.0.1:8000/admin/` and log in with your superuser credentials.

## 9. Project Structure
- `backend/` - Django backend code (apps, models, views, etc.)
- `frontend/` - Static files and HTML templates
- `requirements.txt` - Python dependencies

## 10. Additional Notes
- For custom admin or service setup, see the guides in `backend/ADMIN_ACCESS_GUIDE.md` and `backend/ADMIN_INTERFACE_GUIDE.md`.
- To add new apps or features, use Django's standard app creation and registration process.

## 11. Running Tests
To run tests for the backend apps:
```powershell
python manage.py test
```

## 12. Deactivating the Virtual Environment
When finished, deactivate the virtual environment:
```powershell
deactivate
```

---
For further questions, refer to the documentation files in the `backend/` directory or contact the project maintainer.
