flwr federation simulation-config --num-supernodes 10 --client-resources-num-cpus 1 --client-resources-num-gpus 1 --init-args-num-cpus 1 --init-args-num-gpus 1
for v in -1 0 1 2 3 4 5 6 7 8 9 10; do
  sh mobilebert.sh bert_layers_$v "tune_layers=$v num-server-rounds=15 noise-multiplier=1.1 learning-rate=0.00002 batch-size=32"
done
sh poweroff.sh
