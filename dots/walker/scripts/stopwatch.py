#!/usr/bin/env python3
import signal
import sys
import time


def format_elapsed(seconds: float) -> str:
    whole = int(seconds)
    hours, remainder = divmod(whole, 3600)
    minutes, secs = divmod(remainder, 60)
    hundredths = int((seconds - whole) * 100)
    return f"{hours:02d}:{minutes:02d}:{secs:02d}.{hundredths:02d}"


def main() -> int:
    print("Walker Stopwatch")
    print("Press Ctrl+C to stop.")
    start = time.monotonic()

    def handle_sigint(signum, frame):
        raise KeyboardInterrupt

    signal.signal(signal.SIGINT, handle_sigint)

    try:
        while True:
            elapsed = time.monotonic() - start
            print(f"\rElapsed: {format_elapsed(elapsed)}", end="", flush=True)
            time.sleep(0.05)
    except KeyboardInterrupt:
        elapsed = time.monotonic() - start
        print(f"\rFinal time: {format_elapsed(elapsed)}")
        print()
        try:
            input("Press Enter to close...")
        except EOFError:
            pass
    return 0


if __name__ == "__main__":
    sys.exit(main())
