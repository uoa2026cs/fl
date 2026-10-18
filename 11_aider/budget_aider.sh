flwr federation simulation-config --init-args-num-cpus 1 --init-args-num-gpus 1\
 --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1
mkdir -p results

# defaults batch_size=32 delta=1e-05 random_seed=0
# dataset = datasets.concatenate_datasets([dataset] * 10)
# mask = torch.tensor([l.item() > 1 for l in labels], device=device)  # > normal, traffic
# dataset=\"aider-224\" num_labels=5\
for v in 0; do
  flwr run mobilenetv3aider --run-config "noise_normal=1.16 noise_multiplier=0.65 random_seed=$v\
    normal_rounds=180 num_rounds=200 max_grad_norm=2 learning_rate=0.01 tune_layers=1" --stream
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/aider_065_$finished.txt 2>/dev/null

  flwr run mobilenetv3aider --run-config "noise_normal=1.06 noise_multiplier=0.75 random_seed=$v\
    normal_rounds=180 num_rounds=200 max_grad_norm=2 learning_rate=0.01 tune_layers=1" --stream
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/aider_075_$finished.txt 2>/dev/null

  flwr run mobilenetv3aider --run-config "noise_normal=1.03 noise_multiplier=0.85 random_seed=$v\
    normal_rounds=180 num_rounds=200 max_grad_norm=2 learning_rate=0.01 tune_layers=1" --stream
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/aider_085_$finished.txt 2>/dev/null

  flwr run mobilenetv3aider --run-config "noise_normal=1 noise_multiplier=1 random_seed=$v\
    normal_rounds=180 num_rounds=200 max_grad_norm=2 learning_rate=0.01 tune_layers=1" --stream
  finished=$(flwr list | grep finished | head -n 1 | sed -E 's/.\s+([0-9]+).*/\1/')
  flwr log $finished > results/aider_100_$finished.txt 2>/dev/null
done

sh poweroff.sh
