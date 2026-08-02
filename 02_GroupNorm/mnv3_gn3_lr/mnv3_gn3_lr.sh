flwr federation simulation-config --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1 --init-args-num-cpus 1 --init-args-num-gpus 1
for v in 0.1 0.01 0.001; do
  flwr run mnv3_gn3 --stream --run-config "learning-rate=$v num-server-rounds=15 tune_layers=1"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > assets/mnv3_gn3_lr_$finished.txt 2>/dev/null
done
# sh poweroff.sh
