flwr federation simulation-config --init-args-num-cpus 1 --init-args-num-gpus 1\
 --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1
mkdir -p results

for v in 0.1 0.01 0.001 0.0001 0.00001 0.000001 0.0000001; do
  flwr run distilbert3event --stream --run-config "learning_rate=$v\
    noise_multiplier=1 max_grad_norm=0.00005 num_rounds=15 tune_layers=2"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/ec_lr2_$finished.txt 2>/dev/null
done

# sh poweroff.sh
