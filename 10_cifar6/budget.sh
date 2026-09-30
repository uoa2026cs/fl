echo -n "deleting and rebuilding flwr.csv [enter] "
read -r -s
echo
rm -f flwr.csv
python flwr_csv.py "budget_*.txt"
echo "id,seed,round,accuracy,loss" > flwr_all.csv
grep -v _sub flwr.csv | grep 100s | sed "s/100s/fixed,/" >> flwr_all.csv
grep -v _sub flwr.csv | grep 085s | sed "s/085s/dpa-dp-0.85,/" >> flwr_all.csv
grep -v _sub flwr.csv | grep 075s | sed "s/075s/dpa-dp-0.75,/" >> flwr_all.csv
grep -v _sub flwr.csv | grep 065s | sed "s/065s/dpa-dp-0.65,/" >> flwr_all.csv
echo "id,seed,round,accuracy,loss" > flwr_sub.csv
grep _sub flwr.csv | sed "s/_sub//" | grep 100s | sed "s/100s/fixed,/" >> flwr_sub.csv
grep _sub flwr.csv | sed "s/_sub//" | grep 085s | sed "s/085s/dpa-dp-0.85,/" >> flwr_sub.csv
grep _sub flwr.csv | sed "s/_sub//" | grep 075s | sed "s/075s/dpa-dp-0.75,/" >> flwr_sub.csv
grep _sub flwr.csv | sed "s/_sub//" | grep 065s | sed "s/065s/dpa-dp-0.65,/" >> flwr_sub.csv
rm flwr.csv
