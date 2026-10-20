flwr federation simulation-config --init-args-num-cpus 1 --init-args-num-gpus 1\
 --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1
mkdir -p results

# defaults delta=1e-05 dataset_multiplier=1
# max_grad_norm=0.0001 learning_rate=0.001 tune_layers=2 batch_size=32
# dataset=\"ec\" num_labels=14 subset=\"6,7,8,9,10,11,12,13\" normal_rounds=180 num_rounds=200
for v in 0; do
  flwr run distilbert3event --stream --run-config "noise_normal=1 noise_multiplier=1 random_seed=$v"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/ec_100_$finished.txt 2>/dev/null

  flwr run distilbert3event --stream --run-config "noise_normal=1.03 noise_multiplier=0.85 random_seed=$v"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/ec_085_$finished.txt 2>/dev/null

  flwr run distilbert3event --stream --run-config "noise_normal=1.08 noise_multiplier=0.75 random_seed=$v"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/ec_075_$finished.txt 2>/dev/null

  flwr run distilbert3event --stream --run-config "noise_normal=1.35 noise_multiplier=0.65 random_seed=$v"
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/ec_065_$finished.txt 2>/dev/null
done

sh poweroff.sh
