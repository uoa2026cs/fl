flwr federation simulation-config --init-args-num-cpus 1 --init-args-num-gpus 1\
 --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1
mkdir -p results

for v in 0.002 0.005 0.01 0.02 0.05 0.1 0.2 0.5 1 2 5; do
  flwr run distilbert3event --stream --run-config "max_grad_norm=$v\
    noise_multiplier=1 learning_rate=0.001 num_rounds=15 tune_layers=2"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/ec_norm_$finished.txt 2>/dev/null
done

# sh poweroff.sh
