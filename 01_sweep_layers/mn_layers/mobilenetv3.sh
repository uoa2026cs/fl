[ -d assets/cifar10-example ] || python mobilenetv3/download.py
flwr run mobilenetv3 --stream --run-config "$2"
rm -f assets/tmp.pt
finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
flwr log $finished > assets/$1_$finished.txt 2>/dev/null
