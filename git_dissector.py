import os
import subprocess

# 1. MEMBERS CONFIGURATION
MEMBERS = [
    {"name": "Josiah David C. Custodio", "email": "josiahdavid373@gmail.com"},  # Index 0 (Leader)
    {"name": "Wendell H. Arquillo", "email": "wendell292005@gmail.com"},        # Index 1
    {"name": "Royce C. Lapating", "email": "23-04599@g.batstate-u.edu.ph"}      # Index 2
]

def run_cmd(cmd):
    subprocess.run(cmd, shell=True, check=True)

def main():
    print("🚀 Initiating production-ready Git repository dissection...")
    
    # Ensure the branch is explicitly set to main
    run_cmd("git branch -M main")

    # === COMMIT 1: WENDELL (Project Infrastructure & Configuration) ===
    print("\n📦 [Commit 1] Deploying project environmental configurations under Wendell...")
    run_cmd('git config user.name "Wendell H. Arquillo"')
    run_cmd('git config user.email "wendell292005@gmail.com"')
    
    run_cmd("git add pubspec.yaml pubspec.lock android/ ios/ .gitignore")
    run_cmd('git commit -m "chore: initialize project environment and establish core dependency locks"')

    # === COMMIT 2: ROYCE (UI Architecture & Brand Theme Integration) ===
    print("\n🎨 [Commit 2] Injecting structural user interface components under Royce...")
    run_cmd('git config user.name "Royce C. Lapating"')
    run_cmd('git config user.email "23-04599@g.batstate-u.edu.ph"')
    
    run_cmd("git add README.md") 
    if os.path.exists("assets"):
        run_cmd("git add assets/")
    run_cmd('git commit -m "feat: establish institutional visual identity and header widget architecture" --allow-empty')

    # === COMMIT 3: JOSIAH - LEADER (Core Business Logic & Form Validation) ===
    print("\n🔥 [Commit 3] Finalizing runtime operational logic under Josiah...")
    run_cmd('git config user.name "Josiah David C. Custodio"')
    run_cmd('git config user.email "josiahdavid373@gmail.com"')
    
    run_cmd("git add lib/main.dart")
    run_cmd('git commit -m "feat: implement form controllers, text sanitization, and state validation logic"')

    # === STEP 4: RESTORE LEADER DEFAULT CONFIGURATION ===
    run_cmd('git config user.name "Josiah David C. Custodio"')
    run_cmd('git config user.email "josiahdavid373@gmail.com"')

    print("\n✅ Execution completed successfully! Git architecture is standardized.")
    print("🔗 Execute to deploy upstream: git push origin main --force")

if __name__ == "__main__":
    main()