flwr federation simulation-config --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1 --init-args-num-cpus 1 --init-args-num-gpus 1
for v in 1 0.1 0.01 0.001 0.0001 0.00001 0.000001 0.0000001; do
  flwr run mnv3_wo_opacus --stream --run-config "learning-rate=$v num-server-rounds=15 tune_layers=1"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > assets/mnv3woo_lr_$v_$finished.txt 2>/dev/null
done
# sh poweroff.sh
