from multiprocessing import Pool
import subprocess as sp
import shutil as sh
import tempfile as tf
import os
import time

from utils import *

VSOC_EXEC = os.environ['HOME'] + '/FrankenRV/hdl/sim/obj_dir/VSOC'
MAX_JOBS = 12
TIMEOUT = 3600


class VerilatorRunResult:
    def __init__(self, status:RunStatus, benchmark:str, time_taken:float, message:str=None):
        self.status = status
        self.benchmark = benchmark
        self.time_taken = time_taken
        self.message = message


def run_verilator(hex_file, output_dir) -> VerilatorRunResult:
    output_dir = os.path.abspath(output_dir)
    benchmark = os.path.basename(hex_file).split('.')[0]

    with tf.TemporaryDirectory() as temp_dir:
        print(f'Running {benchmark} in {temp_dir}')
        os.mkdir(f'{temp_dir}/obj')
        sh.copyfile(f'{VSOC_EXEC}', f'{temp_dir}/obj/VSOC')
        sh.copymode(f'{VSOC_EXEC}', f'{temp_dir}/obj/VSOC')
        os.mkdir(f'{temp_dir}/mem')
        sh.copyfile(hex_file, f'{temp_dir}/mem/firmware.hex')

        cmd = f'{temp_dir}/obj/VSOC > {output_dir}/{benchmark}'
        start = time.time()
        proc = sp.run(cmd, shell=True, capture_output=True, timeout=TIMEOUT, cwd=f'{temp_dir}/obj')
        end = time.time()
        time_taken = end - start

        if proc.returncode != 0:
            message = proc.stderr.decode()
            return VerilatorRunResult(RunStatus.FAILED, benchmark, time_taken, message)

        return VerilatorRunResult(RunStatus.SUCCESS, benchmark, time_taken)


def run_all_verilator(hex_dir, output_dir):
    hex_files_to_run = []
    for fname in os.listdir(hex_dir):
        if fname.endswith('.hex'):
            hex_files_to_run.append(os.path.join(hex_dir, fname))

    num_jobs = MAX_JOBS
    job_pool = Pool(processes=num_jobs)

    for _, hex_file in enumerate(hex_files_to_run):
        job_pool.apply_async(run_verilator, args=(hex_file,output_dir), callback=success_callback, error_callback=failure_callback)

    job_pool.close()
    job_pool.join()


def success_callback(result:VerilatorRunResult):
    if result.status == RunStatus.SUCCESS:
        print(f'{result.benchmark} completed sucessfully in {result.time_taken} seconds')
    else:
        print(f'{result.benchmark} failed after {result.time_taken} seconds')

    if result.message is not None:
        print(result.message)


def failure_callback(msg:str):
    print("Thread pool error: " + str(msg))


help_msg = '''
This script runs a Verilator executable for which the firmware is taken from the hex file(s) provided.
The input can be a single hex file or a directory containing multiple hex files.
If a directory is provided, all hex files in that directory are processed in parallel.
The output will be saved in the specified output directory.
'''


def main():
    parent_parser = get_parent_parser(True, True)
    parser = argparse.ArgumentParser(parents=[parent_parser], description=help_msg)
    args = parser.parse_args()

    output_dir = args.output
    check_dir_exists(output_dir, True)

    if (check_file_exists(args.input)):
        res = run_verilator(args.input, output_dir)
        success_callback(res)
    elif (check_dir_exists(args.input, False)):
        run_all_verilator(args.input, output_dir)
    else:
        print('Invalid input. Please provide a valid hex file or directory containing hex files.')

    return


if __name__ == '__main__':
    main()
