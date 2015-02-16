rm -rf input/stream2
rm -rf output/stream2
cp bigdata/data/moby.txt input/stream2
#hadoop/bin/hadoop  jar ./hadoop-streaming-2.6.0.jar \
hadoop/bin/hadoop  jar ./bigdata/hadoop/contrib/hadoop-streaming-2.6.0.jar \
    -input input/stream2 \
    -output output/stream2 \
    -mapper ./bigdata/streaming/mapper.py \
    -reducer ./bigdata/streaming/reducer.py

