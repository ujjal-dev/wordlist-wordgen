# 🔐 OSINT Psychology Wordlist Generator

<div align="center">

![Version](https://img.shields.io/badge/version-3.0-blue)
![Python](https://img.shields.io/badge/python-3.7+-green)
![License](https://img.shields.io/badge/license-MIT-red)
![OSINT](https://img.shields.io/badge/OSINT-Security-purple)

**Advanced Wordlist Generator Based on Human Password Psychology**

⚠️ **For Authorized Security Testing Only** ⚠️

[Features](#features) • [Installation](#installation) • [Usage](#usage) • [Documentation](#documentation)

</div>

---

## 📋 Table of Contents

- [About The Tool](#about-the-tool)
- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage Guide](#usage-guide)
- [Psychology Patterns](#psychology-patterns)
- [Mutation Types](#mutation-types)
- [Semantic Categories](#semantic-categories)
- [Examples](#examples)
- [Output Format](#output-format)
- [Legal Disclaimer](#legal-disclaimer)
- [Author](#author)
- [Support](#support)

---

## 🎯 About The Tool

The **OSINT Psychology Wordlist Generator** is an intelligent password wordlist generator that leverages human psychology patterns. Unlike traditional brute-force wordlists, this tool generates passwords based on **how real humans actually create passwords** using their personal information, interests, and psychological tendencies.

### Why This Tool?

- **Real-world accuracy**: Based on actual human password creation patterns
- **Psychological approach**: Understands how people think when creating passwords
- **OSINT integration**: Uses open-source intelligence gathering principles
- **Targeted generation**: Creates wordlists specific to individual targets
- **Time-efficient**: Generates high-probability passwords instead of millions of random combinations

---

## ✨ Features

### Core Features
- ✅ **12 Psychology Patterns** - Based on real human behavior
- ✅ **15+ Semantic Categories** - Technology, Cricket, God, Gaming, Love, etc.
- ✅ **10+ Mutation Types** - Capitalization, separators, number appending
- ✅ **Interactive CLI** - User-friendly menu system
- ✅ **Colored Output** - Easy-to-read terminal display
- ✅ **Statistics Dashboard** - Pattern distribution analysis
- ✅ **Multiple Export Formats** - TXT and JSON support

### Advanced Features
- 🎯 **Target Profile Integration** - Name, DOB, phone, email, location
- 📚 **Custom Keyword Support** - Add any personal interests
- 🔄 **Real-time Pattern Toggling** - Enable/disable specific patterns
- 📊 **Generation Statistics** - See which patterns generated most words
- 💾 **Save & Export** - Save generated wordlists to files
- 🚀 **Fast Generation** - Optimized algorithm for quick results

---
# 📥 Installation Guide - OSINT Psychology Wordlist Generator

## System Requirements

### Minimum Requirements
- **OS**: Linux, macOS, Windows (10/11), Termux (Android)
- **Python**: Version 3.7 or higher
- **Storage**: 10 MB free space
- **RAM**: 512 MB minimum
- **Internet**: Required only for GitHub clone

### Recommended Requirements
- **OS**: Ubuntu 20.04+ / macOS 12+ / Windows 11
- **Python**: Version 3.9+
- **Storage**: 50 MB free space
- **RAM**: 1 GB
- **Terminal**: Any modern terminal with color support

---

## 📦 Installation Methods

### Method 1: One-Line Install (Linux/macOS)

```bash
# Download and make executable in one command
curl -o wordgen https://raw.githubusercontent.com/ujjal-dev/wordlist-wordgen/main/wordgen && chmod +x wordgen && ./wordgen

## 📦 Installation

### Prerequisites
- Python 3.7 or higher
- Git (optional, for cloning)

### Method 1: Direct Download

```bash
# Download the script
curl -O https://raw.githubusercontent.com/ujjal-dev/wordlist-wordgen/main/wordgen

# Make executable
chmod +x wordgen

# Run
./wordgen

# Clone the repository
git clone https://github.com/ujjal-dev/wordlist-wordgen.git

# Navigate to directory
cd wordlist-wordgen

# Make executable
chmod +x wordgen

# Run
./wordgen

# Download the Python script
curl -O https://raw.githubusercontent.com/ujjal-dev/wordlist-wordgen/main/wordgen.py

# Run with Python
python3 wordgen.py

╔════════════════════════════════════════════════════════════════╗
║                      MAIN MENU                                 ║
╠════════════════════════════════════════════════════════════════╣
║                                                               ║
║  1. 🎯 Set Target Profile          ║
║  2. 📚 Set Interest Keywords       ║
║  3. ⚙️  Configure Settings          ║
║  4. 🧠 Toggle Psychology Patterns   ║
║  5. 🔄 Toggle Mutations            ║
║  6. 🚀 Generate Wordlist           ║
║  7. 💾 Save Last Generated List    ║
║  8. 📖 View Help                  ║
║  9. 🔗 GitHub & Author Info        ║
║  0. ❌ Exit                        ║
║                                                               ║
╚════════════════════════════════════════════════════════════════╝

📝 TARGET PROFILE SETUP
──────────────────────────────────────────────────

First Name *: John
Last Name (optional): Doe
Date of Birth (DD/MM/YYYY or YYYY): 15/08/1990
Phone Number (optional): 9876543210
Email Address (optional): john.doe@gmail.com
Username/Handle (optional): johndoe90
City/Location (optional): New York
Organization/School (optional): ABC Corp


📚 INTEREST KEYWORDS SETUP
──────────────────────────────────────────────────

Available categories:
   1. technology
   2. cricket
   3. football
   4. god
   5. animal
   6. car
   7. money
   8. gaming
   9. music
  10. love
  11. food
  12. sports
  13. nature
  14. movies
  15. bike
   c. Custom keyword (type any word)

Select category number or type custom word (or 'done' to finish): 1
✓ Added: technology

Select category number or type custom word (or 'done' to finish): 4
✓ Added: god

Select category number or type custom word (or 'done' to finish): c
Enter custom keyword: cyberpunk
✓ Added custom: cyberpunk

Select category number or type custom word (or 'done' to finish): done
✅ Added 3 keyword(s)!

⚙️  GENERATION SETTINGS
──────────────────────────────────────────────────

Current Settings:
  • Min Length: 6
  • Max Length: 20
  • Target Size: 500

Min Length (default 6): 8
Max Length (default 20): 16
Target Size (default 500): 1000

✅ Settings updated!

🧠 PSYCHOLOGY PATTERNS
──────────────────────────────────────────────────

   1. Identity Pattern        ✓ ON
   2. Passion Pattern         ✓ ON
   3. Faith Pattern           ✓ ON
   4. Idol Pattern            ✓ ON
   5. Place Pattern           ✓ ON
   6. Brand Pattern           ✓ ON
   7. Nostalgia Pattern       ✓ ON
   8. Leet Speak              ✓ ON
   9. Keyboard Walk           ✓ ON
  10. Lucky Number            ✓ ON
  11. Symbol Append           ✓ ON
  12. Cross Passion           ✓ ON

   0. Back to Main Menu

Enter number to toggle pattern: 3
✓ Faith Pattern turned OFF

🚀 GENERATING WORDLIST...
──────────────────────────────────────────────────
  Target: John Doe
  Keywords: technology, god, cyberpunk
  Length: 8-16
  Target size: 1000
──────────────────────────────────────────────────

📋 SAMPLE OUTPUT (first 20 words):

    1. john1990
    2. John@1990
    3. johnny
    4. krishna108
    5. cyberpunk2024
    6. JOHNDOE
    7. john_doe
    8. godisgreat
    9. technology7
   10. john@apple
   11. cyberpunk123
   12. krishna@john
   13. john1990!
   14. GODLOVE
   15. techjohn
   16. john_1990
   17. cyber@punk
   18. johnny7
   19. krishna1990
   20. johndoe123

... and 980 more words

📊 STATISTICS:
  • Total words generated: 1000
  • Pattern distribution:
    - identity: 342 (34.2%)
    - passion: 245 (24.5%)
    - combo: 156 (15.6%)
    - leet: 98 (9.8%)
    - faith: 87 (8.7%)

✅ Generation complete!

Save to file? (y/n): y
Filename (default: wordlist.txt): john_doe_wordlist.txt
✅ Saved to john_doe_wordlist.txt

╔═══════════════════════════════════════════════════════════════╗
║                      LEGAL DISCLAIMER                         ║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║  This tool is for EDUCATIONAL and AUTHORIZED security        ║
║  testing ONLY!                                                ║
║                                                               ║
║  ⚠️  Unauthorized use against systems you don't own           ║
║      is ILLEGAL and punishable by law.                        ║
║                                                               ║
║  ✅ Always get WRITTEN PERMISSION before testing              ║
║  ✅ Use only on systems you own or have authorization for     ║
║  ✅ Follow responsible disclosure practices                   ║
║                                                               ║
║  The author assumes NO LIABILITY for misuse of this tool.     ║
║  Users are responsible for compliance with local laws.       ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
