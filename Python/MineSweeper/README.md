# Minesweeper Auto-Clicker

An automated tool that recognizes numbers in the a minesweeper game and performs precise clicks to help you play faster.

📌NOTE: just help you play faster. It **cant** solve the minesweeper problem now.

📌But in the future, maybe I could try to add the feature of solving minesweeper problem. 

## Features

- 🖼️ Captures game window screenshots
- 🔢 Recognizes numbers using template matching
- 🖱️ Automatically clicks numbered tiles from right to left
- ⚙️ Configurable settings for click delay and recognition threshold
- 🔍 Window position calibration

## Requirements

check the `requirements.txt`:

- Python 3.x
- OpenCV (`pip install opencv-python`)
- PyGetWindow (`pip install PyGetWindow`)
- PyAutoGUI (`pip install pyautogui`)
- PyWinAuto (`pip install pywinauto`)
- pywin32 (`pip install pywin32`)

## Setup

1. Place number templates (0-8) in the `/figs` folder as PNG files
2. Configure settings in the script:
   - `WINDOW_TITLE`: Your Minesweeper window title
   - `THRESHOLD`: Recognition sensitivity (0-1)
   - `CLICK_DELAY`: Delay between clicks
3. Run the python script ` main.py` as the administrator.
