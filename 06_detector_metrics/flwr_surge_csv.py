import ast
import csv
import glob
import re
import sys

file_name = sys.argv[1]

csv_rows = []
csv_rows_sub = []

with open(file_name) as f:
    file_text = f.read()
ansi = re.search(r"^(.*)Starting Flower Simulation", file_text, flags=re.M).group(1)

values = {}

# split to header, rounds, footer
footer_signature = f"{ansi}Strategy execution finished"
footer_idx = file_text.rfind(footer_signature)
footer = file_text[footer_idx:]
round_signature = f"{ansi}[ROUND "
rounds = file_text[:footer_idx].split(round_signature)
header = rounds[0]
rounds = [f"{round_signature}{p}" for p in rounds]

aggregated = ast.literal_eval(re.search(r"^\s*Aggregated ClientApp-side Train Metrics:\s*({.*?}})",
        footer.replace("\n" + ansi, "\n"), flags=re.M | re.S).group(1))
for k, v in aggregated.items():
    round = int(k)
#    print(str(v))
    for kv, vv in v.items():
        values.setdefault(kv, []).append([kv, round, float(vv)])
#        l = values[kv]
#        if l is None:
#            l = []
#        l.append([kv, round, float(vv)])
#        values[kv] = l

with open("flwr.csv", "w") as f:
    csv_writer = csv.writer(f)
    csv_writer.writerow(["id", "round", "value"])
    for v in values.values():
        csv_writer.writerows(v)
    csv_writer.writerows(csv_rows_sub)
