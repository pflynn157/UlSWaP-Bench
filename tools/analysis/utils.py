import argparse
import os
from enum import Enum

VSOC_EXEC = '/home/danchiba/FrankenRV/hdl/sim/obj_dir/VSOC'

ALL_BENCHMARKS = {
    'Security': ['aes', 'chacha20', 'poly1305', 'rsa', 'ecc', 'sha256'],
    'Communication': ['crc', 'dijkstra', 'patricia', 'lzfx_comp', 'lzfx_decomp', 'lorawan_down', 'lorawan_up'],
    'Signal Processing': ['fft', 'adpcm_encode', 'mp3_encode', 'jpeg_encode', 'susan_edges', 'susan_corners', 'susan_smooth'],
    'AI': ['image_class', 'anomaly', 'activity_rec', 'sensor_fusion'],
    'General': ['basicmath', 'bitcount', 'qsort', 'stringsearch']
}

MEM_TYPES = ['.text', '.rodata', '.data', '.bss', 'stack']
NVM_MEM_TYPES = ['.text', '.rodata', '.data']
RAM_MEM_TYPES = ['.data', '.bss', 'stack']
ARCHITECTURES = ['RISC-V', 'MSP430', 'ARM']
ARCH_COLORS = ['tab:purple', 'tab:orange', 'yellow']
MEM_COLORS = ['tab:purple', 'tab:orange', 'yellow']
ARCH_HATCHES = ['////', '......', '\\\\\\\\']

def get_bench_names() -> list[str]:
    bench_names = []
    for bench_group in ALL_BENCHMARKS.values():
        bench_names += bench_group

    return bench_names


def get_label_xtick_positions() -> list[float]:
    positions = []
    bench_idx = 0
    for i, bench_group in enumerate(ALL_BENCHMARKS.keys()):
        positions.append(bench_idx + (len(ALL_BENCHMARKS[bench_group]) - 0.5) / 2)
        bench_idx += len(ALL_BENCHMARKS[bench_group])

    return positions


def get_line_xticks() -> list[float]:
    positions = [-0.25]
    bench_idx = 0
    for bench_group in ALL_BENCHMARKS.values():
        positions.append(bench_idx + len(bench_group) - 0.25)
        bench_idx += len(bench_group)

    return positions


def get_compact_num(num:int) -> str:
    if num < 1000:
        return str(num)
    elif num < 10000:
        return f'{round(num / 1000, 1)}K'
    elif num < 10**6:
        return f'{round(num / 1000)}K'
    elif num < 10**7:
        return f'{round(num / 10**6, 1)}M'
    elif num < 10**9:
        return f'{round(num / 10**6)}M'
    elif num < 10**10:
        return f'{round(num / 10**9, 1)}G'
    elif num < 10**11:
        return f'{round(num / 10**9)}G'
    else:
        return 'uh-oh'


class RunStatus(Enum):
    SUCCESS = 1
    FAILED = 2


def get_parent_parser(input_reqd:bool = True, output_reqd:bool = False) -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(add_help=False)

    parser.add_argument('-i', '--input', type=str, required=input_reqd, help='Path to the input file or directory')
    parser.add_argument('-o', '--output', type=str, required=output_reqd, help='Path to the output file or directory')

    return parser

# def parse_args():
#     import argparse
#     parser = argparse.ArgumentParser()
#     # parser.add_argument('--hex_file', type=str, help='Path to the hex file')
#     # parser.add_argument('--bin_dir', type=str, help='Directory containing firmware binaries')
#     # parser.add_argument('--hex_dir', type=str, help='Directory containing firmware hex files')
#     # parser.add_argument('--dump_file', type=str, help='Dump file to analyze')
#     # parser.add_argument('--dump_dir', type=str, help='Directory containing verilator dump')

#     # parser.add_argument('--benchmark', type=str, help='Benchmark to run')
#     parser.add_argument('--build_dir', type=str, help='Directory containing object files')
#     parser.add_argument('-i', '--input', type=str, help='Path to the input file or directory')
#     parser.add_argument('-o', '--output', type=str, help='Path to the output file or directory')
#     # parser.add_argument('--input_file', type=str, help='Path to the input file')
#     # parser.add_argument('--output_file', type=str, help='Path to the output file')
#     # parser.add_argument('--input_dir', type=str, help='Directory with input files to parse or run')
#     # parser.add_argument('--output_dir', type=str, help='Directory to store the output files')
#     # parser.add_argument('--plot_file', type=str, help='File in which to store the plot')
#     parser.add_argument('--msp430', action='store_true', help='Parse for MSP430')
#     parser.add_argument('--arm', action='store_true', help='Parse for ARM')
#     parser.add_argument('--riscv', action='store_true', help='Parse for RISC-V')

#     return parser.parse_args()


def check_dir_exists(dir_path:str, create:bool) -> bool:
    if os.path.isdir(dir_path):
        return True
    elif not os.path.exists(dir_path):
        if create:
            print(f'Creating directory: {dir_path}')
            os.mkdir(dir_path)
            return True
        else:
            print(f'{dir_path} does not exist')
            return False
    else:
        print(f'{dir_path} is not a directory')
        exit(1)


def check_file_exists(file_path:str) -> bool:
    if not os.path.isfile(file_path):
        print(f'{file_path} does not exist')
        return False
    else:
        return True


if __name__ == '__main__':
    print('This file is a module and not intended to be run directly.')
