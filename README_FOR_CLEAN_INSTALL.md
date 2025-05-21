# CLEAN REINSTALLATION GUIDE - POST SUPER RESET

**IMPORTANT: These steps are to be followed AFTER running `super_reset_and_reinstall.bat` AND RESTARTING YOUR COMPUTER.**

## Part 1: Install Fresh Software

1.  **Install XAMPP:**
    *   Download the LATEST version of XAMPP from [https://www.apachefriends.org/index.html](https://www.apachefriends.org/index.html).
    *   Install it to the default location (usually `C:\xampp`).
    *   During installation, ensure Apache and MySQL are selected.

2.  **Install Python:**
    *   Download Python 3.10 or 3.11 (avoid 3.12+ for now due to potential compatibility issues with older packages if any) from [https://www.python.org/downloads/](https://www.python.org/downloads/).
    *   **CRITICAL:** During installation, check the box that says "Add Python to PATH".
    *   Install to the default location.

3.  **Verify Installations:**
    *   Open a NEW Command Prompt.
    *   Type `python --version` and press Enter. You should see the Python version you just installed.
    *   Type `pip --version` and press Enter. You should see pip information.
    *   Start XAMPP Control Panel and ensure you can start Apache and MySQL (green lights).

## Part 2: Project Setup (From Scratch)

1.  **Create a NEW Parent Directory for Projects (Optional but Recommended):**
    *   Example: `C:\MyDevProjects` (DO NOT use the old project path directly).

2.  **Clone the Repository into a NEW Folder:**
    *   Open Command Prompt or Git Bash.
    *   Navigate to your new parent directory: `cd C:\MyDevProjects`
    *   Clone the repository: `git clone <YOUR_REPOSITORY_URL> test_servicesbladi_fresh_install`
    *   Navigate into the new project folder: `cd test_servicesbladi_fresh_install`

3.  **Create and Activate Virtual Environment:**
    *   `python -m venv venv`
    *   `venv\Scripts\activate`
    *   Your command prompt should now start with `(venv)`.

4.  **Install Dependencies:**
    *   `pip install --upgrade pip`
    *   `pip install -r requirements.txt`
    *   **CAREFULLY CHECK FOR ANY ERRORS DURING INSTALLATION.** If there are errors, they MUST be resolved before continuing.

5.  **Database Setup (Using XAMPP MySQL):**
    *   Ensure MySQL is running in XAMPP.
    *   Open phpMyAdmin (usually `http://localhost/phpmyadmin`).
    *   Create a NEW database named `servicesbladi_fresh` (or any new unique name).
    *   Update `backend/servicesbladi/settings.py` with the new database name if you changed it, and ensure user/password are correct for your XAMPP MySQL (default is usually user 'root' with no password).

6.  **Run Django Migrations:**
    *   Navigate to the `backend` directory: `cd backend`
    *   `python manage.py makemigrations`
    *   `python manage.py migrate`
    *   **CHECK FOR ERRORS.**

7.  **Create Superuser:**
    *   `python manage.py createsuperuser` (follow prompts)

8.  **Collect Static Files:**
    *   `python manage.py collectstatic --noinput`
    *   **CHECK FOR ERRORS.**

## Part 3: Run the Server and Verify

1.  **Run the Django Development Server:**
    *   Ensure you are still in the `backend` directory with `(venv)` active.
    *   **CRITICAL COMMAND:** `python manage.py runserver`
    *   (Do NOT use `0.0.0.0` or any other IP for now. Do NOT use `--noreload` unless specifically troubleshooting later).

2.  **Verify in Browser:**
    *   Open your web browser in **INCOGNITO/PRIVATE MODE**.
    *   Go to: `http://127.0.0.1:8000/`
    *   Scroll to the footer. You should see:
        `VERSION CHECK: [CURRENT_DATE_TIME_UTC]` (or your server's timezone)
        The timestamp should be VERY RECENT (within minutes of you starting the server).

3.  **If your friend is testing:**
    *   They must follow ALL THE SAME STEPS above on their machine.
    *   When they run the server and check the browser, they should also see a VERY RECENT timestamp in the footer, reflecting *their* server's start time.

## Troubleshooting if it STILL Fails:

1.  **EXACT Error Messages:** Copy the complete error message from the terminal or browser.
2.  **XAMPP Logs:** Check Apache and MySQL logs in XAMPP for any errors.
3.  **Event Viewer (Windows):** Check for any application errors related to Python or Apache.
4.  **Simplify `requirements.txt`:** Temporarily remove less critical packages (especially anything related to `channels` or `daphne` initially) to see if a basic Django setup works, then add them back one by one.
5.  **Network Issues:** Ensure no firewalls or antivirus are blocking `127.0.0.1` or port `8000`.

This comprehensive reset and reinstall process is designed to eliminate any lingering state or configuration issues from previous attempts. 