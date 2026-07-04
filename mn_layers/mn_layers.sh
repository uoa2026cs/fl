flwr federation simulation-config --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1 --init-args-num-cpus 1 --init-args-num-gpus 1
for v in -1 0 1 2 3 4; do
  sh mobilenetv3.sh mn_layers_$v "tune_layers=$v num-server-rounds=15 noise-multiplier=1.1 learning-rate=0.001 batch-size=32"
done
sh poweroff.sh
