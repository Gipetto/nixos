============================================================================
INSTALLATION INSTRUCTIONS
============================================================================

METHOD 1: Quick Install (Recommended)
1. Press Ctrl+Shift+P (Cmd+Shift+P on Mac)
2. Type "Preferences: Open User Settings (JSON)"
3. Add this to your settings.json:

   "workbench.colorCustomizations": {
     Paste the entire "colors" object here
   },
   "editor.tokenColorCustomizations": {
     "textMateRules": [
       Paste the entire "tokenColors" array here
     ]
   }

METHOD 2: Create as Extension
1. Create directory: ~/.vscode/extensions/birren-industrial/
2. Create package.json:
   {
     "name": "birren-industrial",
     "displayName": "Birren Industrial",
     "description": "Mid-century industrial control room theme",
     "version": "1.0.0",
     "engines": {
       "vscode": "^1.60.0"
     },
     "categories": ["Themes"],
     "contributes": {
       "themes": [
         {
           "label": "Birren Industrial Dark",
           "uiTheme": "vs-dark",
           "path": "./themes/birren-industrial-dark.json"
         },
         {
           "label": "Birren Industrial Light",
           "uiTheme": "vs",
           "path": "./themes/birren-industrial-light.json"
         }
       ]
     }
   }

3. Create themes/ directory
4. Split this file into:
   - themes/birren-industrial-dark.json (first theme object)
   - themes/birren-industrial-light.json (second theme object)
5. Reload VSCode
6. Ctrl+K Ctrl+T → Select "Birren Industrial Dark" or "Light"

============================================================================
COLOR PHILOSOPHY
============================================================================

This theme follows Faber Birren's industrial color theory:

DARK MODE:

COOL COLORS (Normal operations):
- Industrial Seafoam (#7fb5a0): Strings, headings, success, primary UI
- Dado Green (#5a8a73): String escapes, active selections
- Info Blue (#5b7a8e): Comments, types, supplementary info

WARM COLORS (Alerts and attention):
- Safety Red (#c83e3a): Errors, numbers, constants (critical values)
- Hazard Orange (#d67d3e): Keywords, tags, modifications (warnings)
- Caution Yellow (#f2b632): Functions, find matches (attention needed)
- Aged Rust (#8b5a3c): Attributes, special elements

NEUTRAL COLORS (Structure):
- Industrial Charcoal (#2a2a28): Background
- Charcoal Light (#3a3a38): Secondary backgrounds
- Instrument Cream (#e8e0d5): Primary text
- Machinery Gray (#6b6b68): Borders, inactive elements
- Concrete Base (#a69f95): Operators, punctuation, muted text

LIGHT MODE:

COOL COLORS (Normal operations):
- Dado Green (#5a8a73): Strings, headings, success, primary UI
- Industrial Seafoam (#7fb5a0): String escapes, bright accents
- Info Blue (#5b7a8e): Types, links, informational

WARM COLORS (Alerts and attention):
- Safety Red (#c83e3a): Errors, numbers, constants (same as dark)
- Aged Rust (#8b5a3c): Keywords, tags (grounded warm tone)
- Hazard Orange (#d67d3e): Functions, warnings (attention)
- Caution Yellow (#f2b632): Find matches, conflicts

NEUTRAL COLORS (Structure):
- Instrument Cream (#e8e0d5): Background
- Cream Dark (#d8d0c5): Secondary backgrounds
- Industrial Charcoal (#2a2a28): Primary text
- Machinery Gray (#6b6b68): Comments, operators
- Concrete Base (#a69f95): Borders, muted elements

FUNCTIONAL COLOR CODING (Both Modes):
- Warm colors only appear for errors, warnings, and important syntax
- Cool colors dominate for everyday code reading
- This reduces visual fatigue and makes problems stand out immediately
- Mirrors control room design where warm = attention required
- Light mode uses deeper greens and more muted warm tones for readability

RECOMMENDED FONT:
"editor.fontFamily": "'IBM Plex Mono', 'Courier Prime', 'JetBrains Mono'"

============================================================================
