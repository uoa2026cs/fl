flwr federation simulation-config --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1 --init-args-num-cpus 1 --init-args-num-gpus 1
for v in -1 0 1 2 3 4 5; do
  flwr run distilbert --stream --run-config "dataset=\"crisismmd\" num_labels=8 learning_rate=0.0001 num_rounds=15 tune_layers=$v"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > assets/$0_$v\_$finished.txt 2>/dev/null
done
# sh poweroff.sh
