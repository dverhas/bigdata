cd /home/vagrant
rm -rf LineGrep 
mkdir  LineGrep
cp bigdata/data/alice.txt LineGrep
cat LineGrep/alice.txt | tr A-Z a-z | tr -cd "a-z\n\t " >LineGrep/alice.p.txt
mkdir input
rm -rf input/grepping
mkdir input/grepping
cp LineGrep/alice.p.txt input/grepping
mkdir output
rm -rf output/grepping
export JAVA_HOME=/usr/lib/jvm/default-java
export PATH=$JAVA_HOME/bin:$PATH
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar
mkdir code
cp bigdata/code/LineGrep.java code
echo "Hadoop initial processing"
hadoop/bin/hadoop com.sun.tools.javac.Main code/LineGrep.java
if [ $? -ne 0 ]; then { echo "compile failed"; exit 1;} fi
echo "Java jar processing"
cd code
jar cf LineGrep.jar LineGrep*.class
cd ..
echo "Hadoop execution"
hadoop/bin/hadoop jar code/LineGrep.jar LineGrep  input/grepping output/grepping
