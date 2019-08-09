#! /bin/sh

bench_db_path="/home/lzw/ceshi"
bench_value="4096"
bench_compression="none" #"snappy,none"

#bench_benchmarks="fillseq,stats,readseq,readrandom,stats" #"fillrandom,fillseq,readseq,readrandom,stats"
#bench_benchmarks="fillrandom,stats,readseq,readrandom,readrandom,readrandom,stats"
#bench_benchmarks="fillrandom,stats,wait,stats,readseq,readrandom,readrandom,readrandom,stats"
#bench_benchmarks="fillrandom,stats,wait,clean_cache,stats,readseq,stats,clean_cache,readrandom,stats"
bench_benchmarks="longpeak,stats"
bench_num="200000"
#bench_readnum="10000"
#bench_max_open_files="1000"
max_background_jobs="4"
#max_bytes_for_level_base="`expr 8 \* 1024 \* 1024 \* 1024`"   #8G
max_bytes_for_level_base="`expr 256 \* 1024 \* 1024`" 

perf_level="1"

stats_interval="100"
stats_interval_seconds="1"
histogram="true"

threads="15"

const_params="
    --db=$bench_db_path \
    --value_size=$bench_value \
    --benchmarks=$bench_benchmarks \
    --num=$bench_num \
    --compression_type=$bench_compression \
    --max_background_jobs=$max_background_jobs \
    --max_bytes_for_level_base=$max_bytes_for_level_base \
    --perf_level=$perf_level \
    --stats_interval=$stats_interval \
    --stats_interval_seconds=$stats_interval_seconds \
    --histogram=$histogram \
    --threads=$threads \
    "

bench_file_path="$(dirname $PWD )/db_bench"

if [ ! -f "${bench_file_path}" ];then
bench_file_path="$PWD/db_bench"
fi

if [ ! -f "${bench_file_path}" ];then
echo "Error:${bench_file_path} or $(dirname $PWD )/db_bench not find!"
exit 1
fi

cmd="$bench_file_path $const_params "

if [ -n "$1" ];then
cmd="nohup $bench_file_path $const_params >>out.out 2>&1 &"
echo $cmd >out.out
fi

echo $cmd
eval $cmd
