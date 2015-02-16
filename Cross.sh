cd /home/vagrant
rm -rf CrossCorrelation 
mkdir  CrossCorrelation
cp bigdata/data/alice.txt CrossCorrelation
cat CrossCorrelation/alice.txt | tr A-Z a-z | tr -cd "a-z\n\t " >CrossCorrelation/alice.p.txt
mkdir input
rm -rf input/cross
mkdir input/cross
cp CrossCorrelation/alice.p.txt input/cross
mkdir output
rm -rf output/cross
export JAVA_HOME=/usr/lib/jvm/default-java
export PATH=$JAVA_HOME/bin:$PATH
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar
mkdir code
cp bigdata/code/CrossCorrelation.java code
echo "Hadoop initial processing"
hadoop/bin/hadoop com.sun.tools.javac.Main code/CrossCorrelation.java
if [ $? -ne 0 ]; then { echo "compile failed"; exit 1;} fi
echo "Java jar processing"
cd code
jar cf CrossCorrelation.jar CrossCorrelation*.class
if [ $? -ne 0 ]; then { echo "run failed"; exit 1;} fi
cd ..
echo "Hadoop execution"
hadoop/bin/hadoop jar code/CrossCorrelation.jar CrossCorrelation input/cross output/cross 
