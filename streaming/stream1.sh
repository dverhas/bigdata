rm -rf input/stream1
rm -rf output/stream1
cp bigdata/data/alice.txt input/stream1
hadoop/bin/hadoop  jar ./bigdata/hadoop/contrib/hadoop-streaming-2.6.0.jar \
    -input input/stream1 \
    -output output/stream1 \
    -mapper /bin/cat \
    -reducer /usr/bin/wc

