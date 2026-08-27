flwr federation simulation-config --init-args-num-cpus 1 --init-args-num-gpus 1\
 --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1
mkdir -p results

# defaults batch_size=32 delta=1e-05 random_seed=0
flwr run mobilenetv3event --run-config "noise_normal=1 noise_multiplier=1\
 normal_rounds=180 num_rounds=200 max_grad_norm=2 learning_rate=0.01 tune_layers=1" --stream

finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
flwr log $finished > results/budget_100_$finished.txt 2>/dev/null
sh poweroff.sh
