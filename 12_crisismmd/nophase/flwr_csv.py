import ast
import csv
import glob
import re
import sys

file_name_pattern = sys.argv[1]
file_num_re = re.compile("^" + file_name_pattern.replace(".", r"\.").replace("*", r"([^_]+).*?") + "$")

def file_num(path):
    return file_num_re.search(path).group(1)

file_names = sorted(glob.glob(file_name_pattern), key=file_num)

csv_rows = []
csv_rows_sub = []
for file_name in file_names:
    with open(file_name) as f:
        file_text = f.read()
    ansi = re.search(r"^(.*)Starting Flower Simulation", file_text, flags=re.M).group(1)

    # split to header, rounds, footer
    footer_signature = f"{ansi}Strategy execution finished"
    footer_idx = file_text.rfind(footer_signature)
    footer = file_text[footer_idx:]
    round_signature = f"{ansi}[ROUND "
    rounds = file_text[:footer_idx].split(round_signature)
    header = rounds[0]
    rounds = [f"{round_signature}{p}" for p in rounds]

    server_eval = ast.literal_eval(re.search(r"^\s*ServerApp-side Evaluate Metrics:\s*({.*?}})",
            footer.replace("\n" + ansi, "\n"), flags=re.M | re.S).group(1))
    for k, v in server_eval.items():
        round = int(k)
        if "ERROR" in rounds[round]:
            break
        csv_rows.append([file_num(file_name), round, float(v["accuracy"]), float(v["loss"])])
        if "sub ac" in v:
            csv_rows_sub.append([str(file_num(file_name)) + "_sub", round, float(v["sub ac"]), float(v["sub ls"])])

with open("flwr.csv", "w") as f:
    csv_writer = csv.writer(f)
    csv_writer.writerow(["id", "round", "accuracy", "loss"])
    csv_writer.writerows(csv_rows)
    csv_writer.writerows(csv_rows_sub)
