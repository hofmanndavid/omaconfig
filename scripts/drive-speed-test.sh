#!/usr/bin/env bash
set -euo pipefail

# drive-speed-test.sh
# Runs sequential and random read/write benchmarks using fio.

if ! command -v fio &>/dev/null; then
  echo "Error: fio is not installed. Install with: sudo pacman -S fio"
  exit 1
fi

TESTDIR="${1:-$HOME}"
TESTFILE="$TESTDIR/fio-speedtest"

cleanup() { rm -f "$TESTFILE".*; }
trap cleanup EXIT

# Extract bw_bytes from fio JSON output and convert to GB/s
gbps() {
  local json="$1" field="$2"
  echo "$json" | python3 -c "import sys,json; print(f\"{json.load(sys.stdin)['jobs'][0]['$field']['bw_bytes']/1e9:.2f} GB/s\")" 2>/dev/null
}

run_fio() {
  fio "$@" --output-format=json 2>/dev/null
}

SEQ_R=$(run_fio --name=seqread --filename="$TESTFILE".seqr --rw=read --size=2G --bs=1M --direct=1 --numjobs=1 --runtime=30)
echo "Sequential Read:  $(gbps "$SEQ_R" read)"

SEQ_W=$(run_fio --name=seqwrite --filename="$TESTFILE".seqw --rw=write --size=2G --bs=1M --direct=1 --numjobs=1 --runtime=30)
echo "Sequential Write: $(gbps "$SEQ_W" write)"

RAND_R=$(run_fio --name=randread --filename="$TESTFILE".randr --rw=randread --size=512M --bs=4k --direct=1 --numjobs=4 --runtime=30 --group_reporting)
echo "Random Read:      $(gbps "$RAND_R" read)"

RAND_W=$(run_fio --name=randwrite --filename="$TESTFILE".randw --rw=randwrite --size=512M --bs=4k --direct=1 --numjobs=4 --runtime=30 --group_reporting)
echo "Random Write:     $(gbps "$RAND_W" write)"
