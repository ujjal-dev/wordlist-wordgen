#!/usr/bin/env python3
"""
OSINT Psychology Wordlist Generator - Standalone Tool
Author: Ujjal Mandal
GitHub: https://github.com/ujjal-dev/wordlist-wordgen
Run with: ./wordgen
"""

import os
import sys
import random
import re
import json
from typing import Dict, List, Set, Optional, Tuple
from datetime import datetime

# ============================================================================
# TERMINAL COLORS
# ============================================================================

class Colors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    PURPLE = '\033[35m'
    BOLD = '\033[1m'
    DIM = '\033[2m'
    RESET = '\033[0m'
    BG_GREEN = '\033[42m'
    BG_RED = '\033[41m'
    BG_BLUE = '\033[44m'

# ============================================================================
# BANNER
# ============================================================================

BANNER = f"""
{Colors.CYAN}{Colors.BOLD}
╔═══════════════════════════════════════════════════════════════════════════════════╗
║                                                                                   ║
║   ██████╗ ███████╗██╗███╗   ██╗████████╗███████╗██████╗                           ║
║  ██╔═══██╗██╔════╝██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗                          ║
║  ██║   ██║███████╗██║██╔██╗ ██║   ██║   █████╗  ██████╔╝                          ║
║  ██║   ██║╚════██║██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗                          ║
║  ╚██████╔╝███████║██║██║ ╚████║   ██║   ███████╗██║  ██║                          ║
║   ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝                          ║
║                                                                                   ║
║   ██╗    ██╗ ██████╗ ██████╗ ██████╗ ██╗     ██╗███████╗████████╗                 ║
║   ██║    ██║██╔═══██╗██╔══██╗██╔══██╗██║     ██║██╔════╝╚══██╔══╝                 ║
║   ██║ █╗ ██║██║   ██║██████╔╝██║  ██║██║     ██║█████╗     ██║                    ║
║   ██║███╗██║██║   ██║██╔══██╗██║  ██║██║     ██║██╔══╝     ██║                    ║
║   ╚███╔███╔╝╚██████╔╝██║  ██║██████╔╝███████╗██║███████╗   ██║                    ║
║    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝╚══════╝   ╚═╝                    ║
║                                                                                   ║
║                 {Colors.GREEN}🔐 PSYCHOLOGY WORDLIST GENERATOR v3.0{Colors.CYAN} ║
║                  {Colors.YELLOW}Author: Ujjal_Mandal | @Ujjal_Mandal{Colors.CYAN} ║
║                                                                                   ║
╚═══════════════════════════════════════════════════════════════════════════════════╝
{Colors.RESET}

{Colors.DIM}⚡ Semantic Expansion + Human Password Psychology | Authorized Security Testing Only{Colors.RESET}
{Colors.RED}{Colors.BOLD}⚠️  WARNING: Unauthorized use against systems you don't own is ILLEGAL{Colors.RESET}
{Colors.DIM}{'═' * 85}{Colors.RESET}
"""

# ============================================================================
# KNOWLEDGE GRAPH
# ============================================================================

KNOWLEDGE = {
    "technology": {
        "subcats": {
            "devices": ["laptop", "desktop", "pc", "mac", "macbook", "iphone", "android", "samsung", "pixel", "ipad", "tablet", "airpods"],
            "brands": ["apple", "google", "microsoft", "samsung", "dell", "hp", "lenovo", "asus", "acer", "sony", "lg", "intel", "nvidia"],
            "components": ["cpu", "gpu", "ram", "ssd", "hdd", "keyboard", "mouse", "monitor", "hdmi", "usb", "wifi", "bluetooth"],
            "software": ["windows", "linux", "ubuntu", "macos", "python", "java", "github", "vscode", "chrome", "firefox", "photoshop"],
        }
    },
    "cricket": {
        "subcats": {
            "players": ["virat", "kohli", "rohit", "sharma", "dhoni", "sachin", "tendulkar", "bumrah", "hardik", "pandya", "jadeja", "ashwin"],
            "teams": ["india", "mumbai", "delhi", "chennai", "bangalore", "kolkata", "csk", "mi", "rcb", "kkr", "srh"],
            "terms": ["six", "four", "century", "wicket", "run", "boundary", "ipl", "worldcup", "t20", "odi", "test"],
        }
    },
    "football": {
        "subcats": {
            "players": ["messi", "ronaldo", "neymar", "mbappe", "haaland", "benzema", "salah", "modric", "kante", "pogba"],
            "clubs": ["barcelona", "madrid", "munich", "liverpool", "chelsea", "arsenal", "manchester", "psg", "juventus"],
            "terms": ["goal", "penalty", "freekick", "worldcup", "champions", "league", "premier", "laliga"],
        }
    },
    "god": {
        "subcats": {
            "hindu": ["krishna", "ram", "shiva", "durga", "ganesh", "hanuman", "vishnu", "lakshmi", "saraswati", "radha", "sita"],
            "islamic": ["allah", "muhammad", "bismillah", "quran", "ramadan", "eid", "mecca", "medina", "786", "108"],
            "christian": ["jesus", "christ", "god", "bible", "amen", "grace", "faith", "church", "cross", "mary"],
            "sacred": ["108", "786", "777", "999", "111", "333", "om", "aum", "jai", "shanti"],
        }
    },
    "car": {
        "subcats": {
            "brands": ["bmw", "audi", "mercedes", "ferrari", "lamborghini", "porsche", "toyota", "honda", "ford", "tesla", "hyundai"],
            "models": ["m3", "m5", "rs6", "gt3", "911", "aventador", "swift", "city", "fortuner", "innova", "creta", "nexon"],
            "terms": ["turbo", "v8", "v6", "bhp", "torque", "drift", "nitro", "engine", "horsepower", "exhaust"],
        }
    },
    "gaming": {
        "subcats": {
            "games": ["pubg", "freefire", "minecraft", "fortnite", "cod", "valorant", "csgo", "lol", "gta", "roblox", "bgmi"],
            "characters": ["mario", "luigi", "pikachu", "charizard", "kratos", "geralt", "lara", "croft", "batman", "spiderman"],
            "terms": ["headshot", "noob", "pro", "clutch", "gg", "ez", "ranked", "legendary", "fps", "ping"],
        }
    },
    "love": {
        "subcats": {
            "terms": ["love", "heart", "kiss", "hug", "baby", "honey", "angel", "sweetheart", "darling", "forever", "together"],
            "flowers": ["rose", "lily", "jasmine", "lotus", "sunflower", "orchid", "daisy", "tulip"],
            "numbers": ["143", "14", "2", "7", "21", "12", "14344"],
        }
    },
    "food": {
        "subcats": {
            "dishes": ["biryani", "pizza", "burger", "pasta", "noodle", "sushi", "taco", "samosa", "dosa", "idli", "paratha"],
            "fruits": ["mango", "apple", "banana", "strawberry", "orange", "watermelon", "grapes", "kiwi", "papaya"],
            "drinks": ["coffee", "tea", "juice", "cola", "pepsi", "redbull", "beer", "wine", "whiskey", "vodka"],
        }
    },
    "music": {
        "subcats": {
            "genres": ["rock", "metal", "jazz", "pop", "hiphop", "rap", "edm", "blues", "classical", "rnb"],
            "artists": ["eminem", "drake", "weeknd", "taylor", "beyonce", "rihanna", "arjit", "rahman", "shreya", "atif"],
            "terms": ["bass", "rhythm", "melody", "chord", "beat", "solo", "acoustic", "concert", "festival", "playlist"],
        }
    },
    "movies": {
        "subcats": {
            "bollywood": ["kgf", "bahubali", "rrr", "pushpa", "pathaan", "jawan", "animal", "dunki", "stree", "bhool", "andhadhun"],
            "hollywood": ["avengers", "batman", "spiderman", "ironman", "thor", "joker", "matrix", "avatar", "titanic", "inception"],
            "actors": ["shahrukh", "salman", "aamir", "hrithik", "deepika", "katrina", "priyanka", "tom", "leonardo", "keanu"],
        }
    },
}

# ============================================================================
# CONSTANTS
# ============================================================================

YEARS = [str(y) for y in range(2000, 2026)]
NUMS = ["1", "2", "3", "7", "9", "0", "12", "21", "69", "99", "100", "123", "321", "007", "786", "108", "420", "1337"]
LUCKY = ["7", "8", "9", "108", "786", "111", "777", "13", "21", "12"]
SACRED = ["786", "108", "1008", "007", "777", "999", "333", "111"]
KEYBOARD = ["qwerty", "123456", "1q2w3e", "qazwsx", "zxcvbn", "asdfgh", "1qaz2wsx", "qweasd", "qwertyuiop"]
SYMS = ["@", "#", "!", "$", "_", ".", "*", "&", "%"]

PSYCH_PATTERNS = {
    "identity": {"name": "Identity Pattern", "default": True},
    "passion": {"name": "Passion Pattern", "default": True},
    "faith": {"name": "Faith Pattern", "default": True},
    "idol": {"name": "Idol Pattern", "default": True},
    "place": {"name": "Place Pattern", "default": True},
    "brand": {"name": "Brand Pattern", "default": True},
    "nostalgia": {"name": "Nostalgia Pattern", "default": True},
    "leetify": {"name": "Leet Speak", "default": True},
    "keyboard": {"name": "Keyboard Walk", "default": True},
    "lucky": {"name": "Lucky Number", "default": True},
    "append": {"name": "Symbol Append", "default": True},
    "combo": {"name": "Cross Passion", "default": True},
}

MUTATIONS = {
    "cap1": {"label": "Capitalize first letter", "default": True},
    "capall": {"label": "ALL CAPS variant", "default": True},
    "sym": {"label": "@Symbol between words", "default": True},
    "dot": {"label": "Dot.separator variants", "default": True},
    "under": {"label": "Under_score variants", "default": True},
    "dash": {"label": "Dash-separator variants", "default": True},
    "year": {"label": "Append years (2000–2025)", "default": True},
    "num": {"label": "Append common numbers", "default": True},
    "dob": {"label": "DOB fragments", "default": True},
    "phone": {"label": "Phone fragments", "default": True},
    "domain": {"label": "Domain-style (@gmail.com)", "default": True},
}

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

def cap_first(s: str) -> str:
    if not s:
        return s
    return s[0].upper() + s[1:] if len(s) > 1 else s.upper()

def cap_all(s: str) -> str:
    return s.upper()

def leetify(s: str) -> str:
    replacements = [('a', '@'), ('A', '@'), ('e', '3'), ('E', '3'), 
                    ('i', '1'), ('I', '1'), ('o', '0'), ('O', '0'),
                    ('s', '$'), ('S', '$'), ('t', '7'), ('T', '7')]
    result = s
    for old, new in replacements:
        result = result.replace(old, new)
    return result

def parse_dob(dob_str: str) -> Tuple[str, str, str, str, str]:
    if not dob_str:
        return '', '', '', '', ''
    dob_str = dob_str.replace('-', '/').replace('.', '/')
    parts = dob_str.split('/')
    if len(parts) == 3:
        d = parts[0].zfill(2)
        m = parts[1].zfill(2)
        y = parts[2]
        yy = y[-2:] if len(y) >= 2 else ''
        md = d + m
        return y, yy, d, m, md
    elif len(dob_str) == 4 and dob_str.isdigit():
        return dob_str, dob_str[-2:], '', '', ''
    return '', '', '', '', ''

def extract_email_parts(email_str: str) -> Tuple[str, str]:
    if not email_str or '@' not in email_str:
        return '', ''
    user, domain = email_str.split('@', 1)
    domain = domain.split('.')[0] if '.' in domain else domain
    return user.lower(), domain.lower()

def lookup_keyword(kw: str) -> Optional[Dict]:
    kw_lower = kw.lower().strip()
    if kw_lower in KNOWLEDGE:
        return {"key": kw_lower, **KNOWLEDGE[kw_lower]}
    for cat, data in KNOWLEDGE.items():
        if cat.startswith(kw_lower) or kw_lower.startswith(cat):
            return {"key": cat, **data}
        for words in data["subcats"].values():
            if any(kw_lower == w for w in words):
                return {"key": cat, **data}
    return None

def clear_screen():
    os.system('clear' if os.name == 'posix' else 'cls')

# ============================================================================
# WORDLIST GENERATOR CLASS
# ============================================================================

class WordlistGenerator:
    def __init__(self):
        self.first_name = ""
        self.last_name = ""
        self.dob = ""
        self.phone = ""
        self.email = ""
        self.username = ""
        self.city = ""
        self.organization = ""
        self.keywords = []
        self.min_length = 6
        self.max_length = 20
        self.target_size = 500
        
        self.dob_year = ""
        self.dob_yy = ""
        self.dob_day = ""
        self.dob_month = ""
        self.dob_md = ""
        self.email_user = ""
        self.email_domain = ""
        self.phone_frags = []
        self.cities = []
        self.orgs = []
        self.kw_by_subcat = {}
        self.kw_flat = []
        
        self.patterns = {k: v["default"] for k, v in PSYCH_PATTERNS.items()}
        self.mutations = {k: v["default"] for k, v in MUTATIONS.items()}
        
        self.candidates: Set[str] = set()
        self.src_map: Dict[str, str] = {}
    
    def set_profile(self, first_name: str, last_name: str = "", dob: str = "", 
                    phone: str = "", email: str = "", username: str = "",
                    city: str = "", organization: str = ""):
        self.first_name = first_name.lower().strip()
        self.last_name = last_name.lower().strip()
        self.dob = dob
        self.phone = phone
        self.email = email.lower().strip()
        self.username = username.lower().strip()
        self.city = city.lower().strip()
        self.organization = organization.lower().strip()
        
        # Parse data
        self.dob_year, self.dob_yy, self.dob_day, self.dob_month, self.dob_md = parse_dob(dob)
        self.email_user, self.email_domain = extract_email_parts(email)
        
        # Phone fragments
        self.phone_frags = []
        if phone:
            phone_clean = re.sub(r'\D', '', phone)
            if len(phone_clean) >= 4:
                self.phone_frags.extend([phone_clean[:4], phone_clean[-4:]])
            if len(phone_clean) >= 6:
                self.phone_frags.extend([phone_clean[:6], phone_clean[-6:]])
            self.phone_frags.append(phone_clean)
            self.phone_frags = list(set(self.phone_frags))
        
        # Location and org
        self.cities = [c.strip() for c in re.split(r'[,\s]+', city) if c.strip()] if city else []
        self.orgs = [o.strip() for o in re.split(r'[\s,]+', organization) if o.strip()] if organization else []
    
    def set_keywords(self, keywords: List[str]):
        self.keywords = keywords
        self.kw_by_subcat = {}
        self.kw_flat = []
        
        for kw in keywords:
            resolved = lookup_keyword(kw)
            if resolved:
                for subcat, words in resolved.get("subcats", {}).items():
                    if subcat not in self.kw_by_subcat:
                        self.kw_by_subcat[subcat] = []
                    for w in words:
                        if w not in self.kw_by_subcat[subcat]:
                            self.kw_by_subcat[subcat].append(w)
                        if w not in self.kw_flat:
                            self.kw_flat.append(w)
            else:
                if "custom" not in self.kw_by_subcat:
                    self.kw_by_subcat["custom"] = []
                if kw not in self.kw_by_subcat["custom"]:
                    self.kw_by_subcat["custom"].append(kw)
                if kw not in self.kw_flat:
                    self.kw_flat.append(kw)
    
    def set_settings(self, min_len: int, max_len: int, target_size: int):
        self.min_length = min_len
        self.max_length = max_len
        self.target_size = target_size
    
    def toggle_pattern(self, pattern: str):
        if pattern in self.patterns:
            self.patterns[pattern] = not self.patterns[pattern]
    
    def toggle_mutation(self, mutation: str):
        if mutation in self.mutations:
            self.mutations[mutation] = not self.mutations[mutation]
    
    def add_word(self, word: str, source: str):
        if word and self.min_length <= len(word) <= self.max_length:
            self.candidates.add(word)
            if word not in self.src_map:
                self.src_map[word] = source
    
    def apply_mutations(self, base: str, source: str):
        if not base or len(base) < 2:
            return
        
        variants = [base]
        if self.mutations.get("cap1", True):
            variants.append(cap_first(base))
        if self.mutations.get("capall", True):
            variants.append(cap_all(base))
        
        for v in variants:
            self.add_word(v, source)
            
            if self.mutations.get("year", True):
                for y in YEARS[:10]:
                    self.add_word(v + y, source)
            
            if self.mutations.get("num", True):
                for n in NUMS[:10]:
                    self.add_word(v + n, source)
            
            if self.mutations.get("sym", True):
                for s in SYMS[:5]:
                    self.add_word(v + s, source)
                    for n in NUMS[:3]:
                        self.add_word(v + s + n, source)
            
            if self.mutations.get("dob", True) and self.dob_year:
                self.add_word(v + self.dob_year, source)
                self.add_word(v + self.dob_yy, source)
                if self.dob_md:
                    self.add_word(v + self.dob_md, source)
            
            if self.mutations.get("phone", True):
                for f in self.phone_frags[:3]:
                    self.add_word(v + f, source)
            
            if self.mutations.get("domain", True):
                domains = ["gmail.com", "yahoo.com", "hotmail.com", "outlook.com"]
                for d in domains:
                    self.add_word(v + "@" + d, source)
    
    def generate(self) -> List[str]:
        self.candidates.clear()
        self.src_map.clear()
        
        if not self.first_name:
            return []
        
        # Identity Pattern
        if self.patterns.get("identity", True):
            src = "identity"
            self.apply_mutations(self.first_name, src)
            if self.last_name:
                self.apply_mutations(self.last_name, src)
                self.apply_mutations(self.first_name + self.last_name, src)
                self.apply_mutations(self.first_name + "_" + self.last_name, src)
            if self.username:
                self.apply_mutations(self.username, src)
            if self.email_user:
                self.apply_mutations(self.email_user, src)
        
        # Passion Pattern
        if self.patterns.get("passion", True) and self.kw_flat:
            src = "passion"
            for kw in self.kw_flat[:15]:
                self.apply_mutations(kw, src)
                self.add_word(kw + self.first_name, src)
                self.add_word(self.first_name + kw, src)
                if self.dob_year:
                    self.add_word(kw + self.dob_year, src)
        
        # Faith Pattern
        if self.patterns.get("faith", True):
            src = "faith"
            for sacred in SACRED[:5]:
                self.add_word(self.first_name + sacred, src)
                for deity in ["krishna", "ram", "shiva", "allah", "jesus"]:
                    self.add_word(deity + sacred, src)
        
        # Idol Pattern
        if self.patterns.get("idol", True):
            src = "idol"
            idol_words = [w for w in self.kw_flat if w in ["virat", "kohli", "messi", "ronaldo", "dhoni"]]
            jersey_nums = ["7", "9", "10", "11", "18", "45"]
            for idol in idol_words[:5]:
                for n in jersey_nums:
                    self.add_word(idol + n, src)
                if self.dob_year:
                    self.add_word(idol + self.dob_year, src)
        
        # Place Pattern
        if self.patterns.get("place", True) and self.cities:
            src = "place"
            for city in self.cities[:3]:
                self.apply_mutations(city, src)
                self.add_word(self.first_name + city, src)
                self.add_word(city + self.first_name, src)
        
        # Brand Pattern
        if self.patterns.get("brand", True):
            src = "brand"
            brand_words = [w for w in self.kw_flat if w in ["apple", "samsung", "bmw", "audi", "nike"]]
            for brand in brand_words[:5]:
                self.apply_mutations(brand, src)
                if self.dob_year:
                    self.add_word(brand + self.dob_year, src)
        
        # Nostalgia Pattern
        if self.patterns.get("nostalgia", True):
            src = "nostalgia"
            nost_words = ["school", "college", "childhood", "home", "friend"]
            for w in nost_words:
                self.add_word(self.first_name + w, src)
                if self.dob_year:
                    self.add_word(self.first_name + w + self.dob_year, src)
            for org in self.orgs[:3]:
                self.apply_mutations(org, src)
        
        # Leet Pattern
        if self.patterns.get("leetify", True):
            src = "leet"
            targets = [self.first_name]
            if self.last_name:
                targets.append(self.last_name)
            targets.extend(self.kw_flat[:10])
            for w in targets:
                l = leetify(w)
                self.add_word(l, src)
                for n in NUMS[:5]:
                    self.add_word(l + n, src)
                if self.dob_year:
                    self.add_word(l + self.dob_year, src)
        
        # Keyboard Pattern
        if self.patterns.get("keyboard", True):
            src = "keyboard"
            for k in KEYBOARD[:5]:
                self.add_word(k, src)
                self.add_word(self.first_name + k, src)
        
        # Lucky Number Pattern
        if self.patterns.get("lucky", True):
            src = "lucky"
            for n in LUCKY[:5]:
                self.add_word(self.first_name + n, src)
                for w in self.kw_flat[:5]:
                    self.add_word(w + n, src)
        
        # Symbol Append Pattern
        if self.patterns.get("append", True):
            src = "append"
            bases = [self.first_name]
            if self.last_name:
                bases.append(self.last_name)
            bases.extend(self.kw_flat[:10])
            for b in bases:
                for s in SYMS[:5]:
                    self.add_word(b + s, src)
        
        # Cross Passion Pattern
        if self.patterns.get("combo", True) and len(self.kw_flat) > 1:
            src = "combo"
            subcats = list(self.kw_by_subcat.keys())[:3]
            for i in range(len(subcats)):
                for j in range(i+1, len(subcats)):
                    words_a = self.kw_by_subcat.get(subcats[i], [])[:3]
                    words_b = self.kw_by_subcat.get(subcats[j], [])[:3]
                    for a in words_a:
                        for b in words_b:
                            self.add_word(a + b, src)
                            for s in SYMS[:3]:
                                self.add_word(a + s + b, src)
        
        # Process results
        seen = set()
        result = []
        for w in sorted(self.candidates):
            w_lower = w.lower()
            if w_lower not in seen:
                seen.add(w_lower)
                result.append(w)
        
        random.shuffle(result)
        return result[:self.target_size]

# ============================================================================
# MENU FUNCTIONS
# ============================================================================

def print_menu():
    """Display main menu"""
    print(f"\n{Colors.CYAN}{Colors.BOLD}╔════════════════════════════════════════════════════════════════╗{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║                      MAIN MENU                                 ║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}╠════════════════════════════════════════════════════════════════╣{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}                                                              {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}1.{Colors.RESET} 🎯 Set Target Profile          {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}2.{Colors.RESET} 📚 Set Interest Keywords       {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}3.{Colors.RESET} ⚙️  Configure Settings          {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}4.{Colors.RESET} 🧠 Toggle Psychology Patterns   {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}5.{Colors.RESET} 🔄 Toggle Mutations            {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}6.{Colors.RESET} 🚀 Generate Wordlist           {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}7.{Colors.RESET} 💾 Save Last Generated List    {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}8.{Colors.RESET} 📖 View Help                  {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}9.{Colors.RESET} 🔗 GitHub & Author Info        {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}  {Colors.GREEN}0.{Colors.RESET} ❌ Exit                        {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}║{Colors.RESET}                                                              {Colors.CYAN}{Colors.BOLD}║{Colors.RESET}")
    print(f"{Colors.CYAN}{Colors.BOLD}╚════════════════════════════════════════════════════════════════╝{Colors.RESET}")
    print()

def set_profile_menu(generator: WordlistGenerator):
    """Interactive profile setup"""
    clear_screen()
    print(BANNER)
    print(f"\n{Colors.GREEN}{Colors.BOLD}📝 TARGET PROFILE SETUP{Colors.RESET}")
    print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}\n")
    
    first_name = input(f"{Colors.YELLOW}First Name {Colors.RED}*{Colors.RESET}: ").strip()
    while not first_name:
        print(f"{Colors.RED}First name is required!{Colors.RESET}")
        first_name = input(f"{Colors.YELLOW}First Name {Colors.RED}*{Colors.RESET}: ").strip()
    
    last_name = input(f"{Colors.YELLOW}Last Name{Colors.RESET} (optional): ").strip()
    dob = input(f"{Colors.YELLOW}Date of Birth{Colors.RESET} (DD/MM/YYYY or YYYY): ").strip()
    phone = input(f"{Colors.YELLOW}Phone Number{Colors.RESET} (optional): ").strip()
    email = input(f"{Colors.YELLOW}Email Address{Colors.RESET} (optional): ").strip()
    username = input(f"{Colors.YELLOW}Username/Handle{Colors.RESET} (optional): ").strip()
    city = input(f"{Colors.YELLOW}City/Location{Colors.RESET} (optional): ").strip()
    organization = input(f"{Colors.YELLOW}Organization/School{Colors.RESET} (optional): ").strip()
    
    generator.set_profile(first_name, last_name, dob, phone, email, username, city, organization)
    
    print(f"\n{Colors.GREEN}✅ Profile saved!{Colors.RESET}")
    input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")

def set_keywords_menu(generator: WordlistGenerator):
    """Interactive keyword setup"""
    clear_screen()
    print(BANNER)
    print(f"\n{Colors.GREEN}{Colors.BOLD}📚 INTEREST KEYWORDS SETUP{Colors.RESET}")
    print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}\n")
    
    print(f"{Colors.CYAN}Available categories:{Colors.RESET}")
    cats = list(KNOWLEDGE.keys())
    for i, cat in enumerate(cats, 1):
        print(f"  {Colors.GREEN}{i:2}.{Colors.RESET} {cat}")
    print(f"  {Colors.GREEN} c.{Colors.RESET} Custom keyword (type any word)\n")
    
    keywords = []
    while True:
        choice = input(f"{Colors.YELLOW}Select category number or type custom word (or 'done' to finish):{Colors.RESET} ").strip().lower()
        
        if choice == 'done':
            break
        
        if choice.isdigit() and 1 <= int(choice) <= len(cats):
            cat = cats[int(choice) - 1]
            keywords.append(cat)
            print(f"{Colors.GREEN}✓ Added: {cat}{Colors.RESET}")
        elif choice == 'c':
            custom = input(f"{Colors.YELLOW}Enter custom keyword:{Colors.RESET} ").strip().lower()
            if custom:
                keywords.append(custom)
                print(f"{Colors.GREEN}✓ Added custom: {custom}{Colors.RESET}")
        else:
            print(f"{Colors.RED}Invalid choice!{Colors.RESET}")
    
    generator.set_keywords(keywords)
    print(f"\n{Colors.GREEN}✅ Added {len(keywords)} keyword(s)!{Colors.RESET}")
    input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")

def settings_menu(generator: WordlistGenerator):
    """Configure generation settings"""
    clear_screen()
    print(BANNER)
    print(f"\n{Colors.GREEN}{Colors.BOLD}⚙️  GENERATION SETTINGS{Colors.RESET}")
    print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}\n")
    
    print(f"{Colors.CYAN}Current Settings:{Colors.RESET}")
    print(f"  • Min Length: {Colors.GREEN}{generator.min_length}{Colors.RESET}")
    print(f"  • Max Length: {Colors.GREEN}{generator.max_length}{Colors.RESET}")
    print(f"  • Target Size: {Colors.GREEN}{generator.target_size}{Colors.RESET}\n")
    
    try:
        min_len = int(input(f"{Colors.YELLOW}Min Length{Colors.RESET} (default {generator.min_length}): ").strip() or generator.min_length)
        max_len = int(input(f"{Colors.YELLOW}Max Length{Colors.RESET} (default {generator.max_length}): ").strip() or generator.max_length)
        target = int(input(f"{Colors.YELLOW}Target Size{Colors.RESET} (default {generator.target_size}): ").strip() or generator.target_size)
        
        if min_len > max_len:
            max_len = min_len
            print(f"{Colors.YELLOW}Adjusted max length to match min length{Colors.RESET}")
        
        generator.set_settings(min_len, max_len, target)
        print(f"\n{Colors.GREEN}✅ Settings updated!{Colors.RESET}")
    except ValueError:
        print(f"{Colors.RED}Invalid input! Settings unchanged.{Colors.RESET}")
    
    input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")

def patterns_menu(generator: WordlistGenerator):
    """Toggle psychology patterns"""
    while True:
        clear_screen()
        print(BANNER)
        print(f"\n{Colors.GREEN}{Colors.BOLD}🧠 PSYCHOLOGY PATTERNS{Colors.RESET}")
        print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}\n")
        
        patterns = list(generator.patterns.items())
        for i, (key, value) in enumerate(patterns, 1):
            status = f"{Colors.GREEN}✓ ON{Colors.RESET}" if value else f"{Colors.RED}✗ OFF{Colors.RESET}"
            name = PSYCH_PATTERNS[key]["name"]
            print(f"  {Colors.GREEN}{i:2}.{Colors.RESET} {name:20} {status}")
        
        print(f"\n  {Colors.GREEN} 0.{Colors.RESET} Back to Main Menu")
        print(f"\n{Colors.DIM}Enter number to toggle pattern{Colors.RESET}")
        
        choice = input(f"\n{Colors.YELLOW}Choice:{Colors.RESET} ").strip()
        
        if choice == '0':
            break
        elif choice.isdigit() and 1 <= int(choice) <= len(patterns):
            key = patterns[int(choice)-1][0]
            generator.toggle_pattern(key)
            new_status = "ON" if generator.patterns[key] else "OFF"
            print(f"\n{Colors.GREEN}✓ {PSYCH_PATTERNS[key]['name']} turned {new_status}{Colors.RESET}")
            input(f"{Colors.DIM}Press Enter...{Colors.RESET}")

def mutations_menu(generator: WordlistGenerator):
    """Toggle mutations"""
    while True:
        clear_screen()
        print(BANNER)
        print(f"\n{Colors.GREEN}{Colors.BOLD}🔄 MUTATIONS{Colors.RESET}")
        print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}\n")
        
        mutations = list(generator.mutations.items())
        for i, (key, value) in enumerate(mutations, 1):
            status = f"{Colors.GREEN}✓ ON{Colors.RESET}" if value else f"{Colors.RED}✗ OFF{Colors.RESET}"
            label = MUTATIONS[key]["label"]
            print(f"  {Colors.GREEN}{i:2}.{Colors.RESET} {label:25} {status}")
        
        print(f"\n  {Colors.GREEN} 0.{Colors.RESET} Back to Main Menu")
        print(f"\n{Colors.DIM}Enter number to toggle mutation{Colors.RESET}")
        
        choice = input(f"\n{Colors.YELLOW}Choice:{Colors.RESET} ").strip()
        
        if choice == '0':
            break
        elif choice.isdigit() and 1 <= int(choice) <= len(mutations):
            key = mutations[int(choice)-1][0]
            generator.toggle_mutation(key)
            new_status = "ON" if generator.mutations[key] else "OFF"
            print(f"\n{Colors.GREEN}✓ {MUTATIONS[key]['label']} turned {new_status}{Colors.RESET}")
            input(f"{Colors.DIM}Press Enter...{Colors.RESET}")

def generate_wordlist(generator: WordlistGenerator, last_result: List):
    """Generate and display wordlist"""
    clear_screen()
    print(BANNER)
    
    if not generator.first_name:
        print(f"{Colors.RED}❌ Please set target profile first!{Colors.RESET}")
        input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")
        return last_result
    
    print(f"\n{Colors.GREEN}{Colors.BOLD}🚀 GENERATING WORDLIST...{Colors.RESET}")
    print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}")
    print(f"  Target: {generator.first_name} {generator.last_name}")
    print(f"  Keywords: {', '.join(generator.keywords[:5]) if generator.keywords else 'None'}")
    print(f"  Length: {generator.min_length}-{generator.max_length}")
    print(f"  Target size: {generator.target_size}")
    print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}\n")
    
    words = generator.generate()
    
    if not words:
        print(f"{Colors.RED}No words generated!{Colors.RESET}")
        input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")
        return last_result
    
    # Display sample
    print(f"{Colors.CYAN}{Colors.BOLD}📋 SAMPLE OUTPUT (first 20 words):{Colors.RESET}\n")
    for i, w in enumerate(words[:20], 1):
        print(f"  {Colors.GREEN}{i:3}.{Colors.RESET} {w}")
    
    if len(words) > 20:
        print(f"\n  {Colors.DIM}... and {len(words) - 20} more words{Colors.RESET}")
    
    # Statistics
    print(f"\n{Colors.CYAN}{Colors.BOLD}📊 STATISTICS:{Colors.RESET}")
    print(f"  • Total words generated: {Colors.GREEN}{len(words)}{Colors.RESET}")
    
    src_counts = {}
    for w in words:
        src = generator.src_map.get(w, "other")
        src_counts[src] = src_counts.get(src, 0) + 1
    
    print(f"  • Pattern distribution:")
    for src, count in sorted(src_counts.items(), key=lambda x: -x[1])[:5]:
        perc = count / len(words) * 100
        print(f"    - {src}: {count} ({perc:.1f}%)")
    
    print(f"\n{Colors.GREEN}✅ Generation complete!{Colors.RESET}")
    
    save_choice = input(f"\n{Colors.YELLOW}Save to file? (y/n):{Colors.RESET} ").strip().lower()
    if save_choice == 'y':
        filename = input(f"{Colors.YELLOW}Filename{Colors.RESET} (default: wordlist.txt): ").strip() or "wordlist.txt"
        try:
            with open(filename, 'w') as f:
                f.write('\n'.join(words))
            print(f"{Colors.GREEN}✅ Saved to {filename}{Colors.RESET}")
        except Exception as e:
            print(f"{Colors.RED}Error saving: {e}{Colors.RESET}")
    
    input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")
    return words

def save_wordlist_menu(words: List):
    """Save previously generated wordlist"""
    clear_screen()
    print(BANNER)
    
    if not words:
        print(f"{Colors.RED}❌ No wordlist generated yet! Please generate first.{Colors.RESET}")
        input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")
        return
    
    print(f"\n{Colors.GREEN}{Colors.BOLD}💾 SAVE WORDLIST{Colors.RESET}")
    print(f"{Colors.DIM}{'─' * 50}{Colors.RESET}")
    print(f"  Words available: {Colors.GREEN}{len(words)}{Colors.RESET}")
    
    filename = input(f"\n{Colors.YELLOW}Filename{Colors.RESET} (default: wordlist.txt): ").strip() or "wordlist.txt"
    
    try:
        with open(filename, 'w') as f:
            f.write('\n'.join(words))
        print(f"{Colors.GREEN}✅ Saved to {filename}{Colors.RESET}")
    except Exception as e:
        print(f"{Colors.RED}Error saving: {e}{Colors.RESET}")
    
    input(f"\n{Colors.DIM}Press Enter to continue...{Colors.RESET}")

def help_menu():
    """Display help information"""
    clear_screen()
    print(BANNER)
    print(f"""
{Colors.GREEN}{Colors.BOLD}📖 QUICK HELP GUIDE{Colors.RESET}
{Colors.DIM}{'─' * 50}{Colors.RESET}

{Colors.YELLOW}1. Set Target Profile{Colors.RESET}
   Enter personal information of the target (name, DOB, location, etc.)

{Colors.YELLOW}2. Set Interest Keywords{Colors.RESET}
   Select from categories: technology, cricket, football, god, car, gaming, 
   love, food, music, movies OR enter custom keywords

{Colors.YELLOW}3. Configure Settings{Colors.RESET}
   Set min/max password length and desired wordlist size

{Colors.YELLOW}4. Psychology Patterns{Colors.RESET}
   Toggle which psychological patterns to use:
   - Identity: Name + birth year
   - Passion: Hobby word + numbers
   - Faith: Religious words + sacred numbers
   - Idol: Celebrity names + jersey numbers
   - Place: City/Landmark combinations
   - Brand: Device/Brand names
   - Leet: Character substitution (a→@, e→3)
   - Keyboard: Keyboard patterns (qwerty, 1qaz)

{Colors.YELLOW}5. Generate{Colors.RESET}
   Create the wordlist based on your settings

{Colors.YELLOW}6. Save{Colors.RESET}
   Export the generated wordlist to a text file

{Colors.RED}{Colors.BOLD}⚠️  LEGAL DISCLAIMER{Colors.RESET}
This tool is for EDUCATIONAL and AUTHORIZED security testing ONLY.
Always get written permission before testing any system you don't own.
{Colors.DIM}{'─' * 50}{Colors.RESET}
""")
    input(f"{Colors.DIM}Press Enter to continue...{Colors.RESET}")

def github_menu():
    """Display GitHub and author information"""
    clear_screen()
    print(BANNER)
    print(f"""
{Colors.PURPLE}{Colors.BOLD}🔗 GITHUB & AUTHOR INFORMATION{Colors.RESET}
{Colors.DIM}{'─' * 50}{Colors.RESET}

{Colors.GREEN}Author:{Colors.RESET}     Ujjal Mandal
{Colors.GREEN}GitHub:{Colors.RESET}     https://github.com/ujjal-dev/wordlist-wordgen
{Colors.GREEN}Twitter:{Colors.RESET}    @ujjalmandal
{Colors.GREEN}LinkedIn:{Colors.RESET}   linkedin.com/in/ujalmandal07

{Colors.YELLOW}📦 Features:{Colors.RESET}
    • 12+ Psychology Patterns based on human behavior
    • 15+ Semantic Categories with 500+ words
    • 10+ Mutation Types for variations
    • Interactive CLI with colored output
    • Statistics and pattern distribution
    • Export to TXT format

{Colors.YELLOW}⭐ Star the repository if you find this tool useful!{Colors.RESET}
{Colors.YELLOW}🐛 Report issues on GitHub for improvements{Colors.RESET}

{Colors.CYAN}📚 Documentation:{Colors.RESET}
    Full user manual available at the GitHub repository.
    Includes examples, best practices, and legal guidelines.

{Colors.DIM}{'─' * 50}{Colors.RESET}
""")
    input(f"{Colors.DIM}Press Enter to continue...{Colors.RESET}")

# ============================================================================
# MAIN FUNCTION
# ============================================================================

def main():
    """Main entry point"""
    generator = WordlistGenerator()
    last_result = []
    
    while True:
        clear_screen()
        print(BANNER)
        print_menu()
        
        choice = input(f"{Colors.YELLOW}Enter your choice (0-9):{Colors.RESET} ").strip()
        
        if choice == '1':
            set_profile_menu(generator)
        elif choice == '2':
            set_keywords_menu(generator)
        elif choice == '3':
            settings_menu(generator)
        elif choice == '4':
            patterns_menu(generator)
        elif choice == '5':
            mutations_menu(generator)
        elif choice == '6':
            last_result = generate_wordlist(generator, last_result)
        elif choice == '7':
            save_wordlist_menu(last_result)
        elif choice == '8':
            help_menu()
        elif choice == '9':
            github_menu()
        elif choice == '0':
            print(f"\n{Colors.GREEN}👋 Goodbye! Stay ethical.{Colors.RESET}\n")
            sys.exit(0)
        else:
            print(f"{Colors.RED}Invalid choice! Please enter 0-9{Colors.RESET}")
            input(f"{Colors.DIM}Press Enter to continue...{Colors.RESET}")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n\n{Colors.YELLOW}⚠️  Interrupted by user{Colors.RESET}")
        sys.exit(0)