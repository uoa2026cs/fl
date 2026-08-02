[ -d assets/emotion-distilbert ] || python distilbert/download.py
flwr run distilbert --stream --run-config "$2"
rm -f assets/tmp.pt
finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
flwr log $finished > assets/$1_$finished.txt 2>/dev/null
