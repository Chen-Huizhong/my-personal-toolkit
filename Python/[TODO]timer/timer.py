import time

class _Timer:
    def __init__(self):
        self._start_time = None
        self._elapsed = 0.0
        self._running = False

    def start(self):
        if not self._running:
            print("Starting timer...")
            self._start_time = time.perf_counter()
            self._running = True
        else:
            self.reset()
            self.start()

    def stop(self):
        if self._running:
            elapsed = time.perf_counter() - self._start_time
            self._elapsed = elapsed
            self._running = False
            print(f"Elapsed time: {self._elapsed:.4f} seconds")
            return self._elapsed
        else:
            print("Timer is not running. Please start the timer first.")
            return None

    def reset(self):
        self._start_time = None
        self._elapsed = 0.0
        self._running = False

Timer = _Timer()