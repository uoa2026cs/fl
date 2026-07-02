flwr federation simulation-config --num-supernodes 2 --client-resources-num-cpus 1 --client-resources-num-gpus 1 --init-args-num-cpus 1 --init-args-num-gpus 1
for v in 0.00001 0.0001; do
  sh mobilebert.sh sweep_test_$v "learning-rate=$v num-server-rounds=1"
done
sh poweroff.sh
