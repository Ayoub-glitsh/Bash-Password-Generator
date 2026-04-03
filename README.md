

<p align="center">
  <!-- Bash -->
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/bash/bash-original.svg" width="80"/>

  <!-- Linux -->
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/linux/linux-original.svg" width="80"/>

  <!-- Git -->
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg" width="80"/>

  <!-- GitHub -->
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" width="80"/>

  <!-- Terminal -->
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/ubuntu/ubuntu-plain.svg" width="80"/>
</p>



<p align="center">
  <img src="https://readme-typing-svg.herokuapp.com/?lines=Secure+Password+Generator&center=true&width=800&height=100&size=40">
</p>


# Secure Password Generator  

<img src="https://i.postimg.cc/c4Y8sPRY/password-generator-bash.png" alt="description"> 

A feature-rich Bash script for generating cryptographically secure passwords using `/dev/urandom`.

## ✨ Features

- **Custom Length**: Choose your desired password length (default: 16).
- **Flexible Character Sets**: Choose to include uppercase letters, numbers, and special characters.
- **Secure Randomness**: Uses `/dev/urandom` for generating passwords.
- **Multiple Passwords**: Generate dozens of passwords at once.
- **Strength Indicator**: Real-time evaluation of password complexity (Weak/Medium/Strong).
- **Smart Clipboard Support**: Automatically copies the generated password to your clipboard (supports `xclip`, `pbcopy`, and `clip.exe`).
- **Save to File**: Option to export your generated passwords to a timestamped `.txt` file.
- **Rich UI**: Colorized output with a clean terminal experience.

## 🚀 Installation & Usage

### ⚙️ Prerequisites
This script requires a Bash-compatible environment.
- **Linux/macOS**: Native support.
- **Windows**: Use [Git Bash](https://gitforwindows.org/), [WSL](https://learn.microsoft.com/en-us/windows/wsl/install), or [Cygwin](https://www.cygwin.com/).

### ⚡ Quick Start

   
1. **Make the script executable (Mac/Linux)**:
   ```bash
   chmod +x password_generator.sh
   ```


2. **Run the script**:
    ```bash
   # Method 1: Using the executable (Linux/Mac/Git Bash)
   ./password_generator.sh

   # Method 2: Calling bash directly (Works on all platforms)
   bash password_generator.sh
   ```

---

## 🛠️ Usage Example

```text
  ╔════════════════════════════════════════╗
  ║        Secure Password Generator       ║
  ╚════════════════════════════════════════╝

Enter password length (default 16): 32
Include uppercase letters? (y/n, default y): y
Include numbers? (y/n, default y): y
Include special characters? (y/n, default y): y
How many passwords to generate? (default 1): 3
Save to file? (y/n, default n): y

--- Generated Passwords ---

Password #1: x7$v&QwP!2mZ9#Lp0*R5@T8^Yv1!9k8p
Strength: STRONG (Score: 6/6)
-----------------------------------
Password #2: ...
...
```

## 📜 Code Overview

- **Source of Randomness**: `/dev/urandom` is read and filtered via `tr` to ensure maximum entropy.
- **Encoding**: Uses `LC_ALL=C` to prevent errors when handling non-ASCII characters or locale-specific variations.
- **Modularity**: Functions like `check_strength` and `copy_to_clipboard` make the code easy to maintain and expand.
