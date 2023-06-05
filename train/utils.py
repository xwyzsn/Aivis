import os
import uuid
import subprocess
MODELS = {
    "Triformer":"E:\\python310\\python G:\\desktop\\ToTrain\\train\Triformer\\main.py --data ETTh1 --model pa"
}

COLS = {
    "Triformer":[
        ("date","datetime"),
        ("y_pred","float")
    ]
}

def exec_cmd(cmd:str):
    """
    Execute a command in the terminal,write the output to the ./tmp/
    """
    # tmp_file = f"./tmp/{uuid.uuid4()}.tmp"
    # os.system(f"{cmd} > {tmp_file}")
    # with open(tmp_file,"r") as f:
    #     output = f.read()
    # os.remove(tmp_file)
    # return output
    try:
        cmd  = f"cd  G:\\desktop\\ToTrain\\train\Triformer && {cmd}"
        print(f"runing {cmd}")
        res = subprocess.run(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,encoding='gbk')
        if res.returncode == 0:
            print(res.stdout)
            return res.stdout
        else:
            print(res.stderr)
            return res.stderr
    except Exception as e:
        print(e)

if __name__ == '__main__':
    print(exec_cmd("dir"))

