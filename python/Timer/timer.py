"""
This is a small python script worked as a timer. 
Just like a stopwatch, you can start and stop it.
And it would tell you the elapsed time.

Usage:
    import timer as t

    t.start()  # start a timer, which would print a message
    t.stop()   # stop the timer, which would print a message

Code by Chen Huizhong, 2025-06-15.

TODO:
- Maybe I should construct this as a class? or a package?
"""

import time

start_time = None
elapsed = 0.0
running = False

def start(msg=None):
    global start_time, running

    if not running:
        if msg is not None: 
            print(msg)
        print(">>> Starting timer...")
        start_time = time.perf_counter()
        running = True
    else:
        reset()
        start()

def stop(msg=None):
    global start_time, running, elapsed

    if running:
        elapsed = time.perf_counter() - start_time
        running = False
        print(f">>> Elapsed time: {elapsed:.4f} seconds")
        if msg is not None: 
            print(msg)
        return elapsed
    else:
        print(">>> Timer is not running. Please start the timer first.")
        return None

def reset():
    global start_time, running, elapsed
    
    start_time = None
    elapsed = 0.0
    running = False