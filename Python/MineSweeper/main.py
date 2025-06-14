"""
A program to help play minesweeper faster. 

Code by Chen Huizhong, 2025-06-14.
Email: hzchen0035@qq.com

TODO:
- The feature for solving minesweeper problem.
"""


import cv2
import numpy as np
import pygetwindow as gw
import pyautogui
import time
import os
from pywinauto.application import Application
import win32api
import win32con
import tkinter as tk
from tkinter import messagebox

# ----------------------
# Configuration
# ----------------------
TEMPLATE_FOLDER = "figs"  # folder of number templates
WINDOW_TITLE = "Let's Minesweeper"  # window name of minesweeper program
THRESHOLD = 0.75  # threshold of recogization
CLICK_DELAY = 0.005  # interval between two click
USE_FASTEST_METHOD = True  # fast or slow
CALIBRATE_CLICKS = True  # check if the click is right


# ----------------------
# Loading number templates
# ----------------------
def load_templates():
    templates = {}
    for filename in os.listdir(TEMPLATE_FOLDER):
        if filename.endswith(".png"):
            num = os.path.splitext(filename)[0]
            templates[num] = cv2.imread(
                os.path.join(TEMPLATE_FOLDER, filename), cv2.IMREAD_GRAYSCALE
            )
    return templates


# ----------------------
# Geting windown information
# ----------------------
def get_window_info(title):
    try:
        win = gw.getWindowsWithTitle(title)[0]
        if not win:
            raise Exception(f"Can't find the window named '{title}'")
        return win.left, win.top, win.width, win.height, win
    except Exception as e:
        raise Exception(f"Failed to get window info: {e}")


# ----------------------
# Screenshot
# ----------------------
def screenshot_window(left, top, width, height):
    screenshot = pyautogui.screenshot(region=(left, top, width, height))
    return cv2.cvtColor(np.array(screenshot), cv2.COLOR_RGB2BGR)


# ----------------------
# Number recognization
# ----------------------
def find_numbers(img, templates):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    results = []
    for label, template in templates.items():
        h, w = template.shape
        res = cv2.matchTemplate(gray, template, cv2.TM_CCOEFF_NORMED)
        loc = np.where(res >= THRESHOLD)
        for pt in zip(*loc[::-1]):
            results.append((int(label), pt[0], pt[1], w, h))
    return deduplicate(results)


# ----------------------
# De-duplicate to avoid click repeatly
# ----------------------
def deduplicate(points):
    results = []
    for n, x, y, w, h in points:
        duplicate = False
        for _, rx, ry, _, _ in results:
            if abs(x - rx) < 5 and abs(y - ry) < 5:
                duplicate = True
                break
        if not duplicate:
            results.append((n, x, y, w, h))
    return results


# ----------------------
# Precise click
# ----------------------
def precise_click(x, y, window_left, window_top):
    abs_x = window_left + x
    abs_y = window_top + y

    # move cursor
    win32api.SetCursorPos((abs_x, abs_y))
    # push left key
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, abs_x, abs_y, 0, 0)
    # delay
    time.sleep(0.001)
    # release left key
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, abs_x, abs_y, 0, 0)


# ----------------------
# Click function
# ----------------------
def click_numbers_app(
    numbers, win_title, window_left, window_top, offset_x=0, offset_y=0
):
    try:
        # from right to left
        sorted_numbers = sorted(numbers, key=lambda item: item[1], reverse=True)

        if USE_FASTEST_METHOD:
            # Method 1: use precise_click()
            for n, x, y, w, h in sorted_numbers:
                cx = x + w // 2 + offset_x
                cy = y + h // 2 + offset_y
                try:
                    precise_click(cx, cy, window_left, window_top)
                    if CLICK_DELAY > 0:
                        time.sleep(CLICK_DELAY)
                except Exception as e:
                    print(f"⚠️ click failed @ ({cx},{cy}): {e}")
        else:
            # Method 2: use pywinauto
            app = Application(backend="win32").connect(title_re=win_title)
            win = app.window(title_re=win_title)
            for n, x, y, w, h in sorted_numbers:
                cx = x + w // 2 + offset_x
                cy = y + h // 2 + offset_y
                try:
                    win.wrapper_object().click_input(
                        coords=(cx, cy), button="left", absolute=False
                    )
                    if CLICK_DELAY > 0:
                        time.sleep(CLICK_DELAY)
                except Exception as e:
                    print(f"⚠️ Click failed @ ({cx},{cy}): {e}")
    except Exception as e:
        print(f"❌ Error while clicking: {e}")


# ----------------------
# Confirm for continuing
# ----------------------
def ask_continue():
    root = tk.Tk()
    root.withdraw()
    # top post
    root.attributes("-topmost", True)
    # confirmation
    result = messagebox.askyesno(
        "Auto-click", "This round finished.\nWant a next round?"
    )

    root.destroy()

    return result


# ----------------------
# main program
# ----------------------
def main():
    print("📦 Loading template(s)...")
    templates = load_templates()
    print(f"✅ Done loading {len(templates)} template(s)")

    print(f"🔍 Initial location of window: {WINDOW_TITLE}")
    left, top, width, height, win = get_window_info(WINDOW_TITLE)
    print(f"📐 Initial coordinates: ({left}, {top}), size: {width}x{height}")

    if CALIBRATE_CLICKS:
        print("\n🔧 Calibating clicks...")
        test_x, test_y = width // 2, height // 2
        print(f"Will click at the center of the window: ({test_x},{test_y})")
        precise_click(test_x, test_y, left, top)
        root = tk.Tk()
        root.withdraw()
        messagebox.showinfo(
            "click calibrated",
            f"Clicked at ({test_x},{test_y})\nPlease check if it's correct.",
        )
        root.destroy()

    while True:
        try:
            print("\n🔄 Relocate the window...")
            left, top, width, height, win = get_window_info(WINDOW_TITLE)
            print(f"📐 New coordinates: ({left}, {top}), size: {width}x{height}")
        except Exception as e:
            print(f"❌ Failed to locate: {e}")
            if not messagebox.askretrycancel(
                "Error", f"Can't locate the window:\n{e}\n\nWant a retry?"
            ):
                print("The end of program")
                break
            continue

        start_time = time.time()

        print("\n🖼️ Start screenshot and recognize...")
        img = screenshot_window(left, top, width, height)
        numbers = find_numbers(img, templates)
        print(f"🔢 Find {len(numbers)} number(s) in total")

        print("🖱️ Clicking...")
        click_start = time.time()
        click_numbers_app(numbers, WINDOW_TITLE, left, top)
        click_duration = time.time() - click_start
        print(f"✅ Done clicking (Time: {click_duration:.3f}s)")

        total_time = time.time() - start_time
        print(f"🕒 Time of this round: {total_time:.3f}s")

        # continue to play?
        if not ask_continue():
            print("The end of the program")
            break


if __name__ == "__main__":
    main()
