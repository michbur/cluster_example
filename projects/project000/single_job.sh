#!/bin/bash

export MY_PROGRAM="./program_name "

cat <<EOF | qsub -r n
#!/bin/bash --login
#PBS -q batch
#PBS -l mem=1000MB
#PBS -l nodes=1:ppn=4
#PBS -N $1
#PBS -M $USER

export CURRDIR=`pwd`

printf -v i "%02d" ${2}
j=SIMULATION_${i}

dir=\${CURRDIR}/\${j}

if [ ! -e \$dir ]
then
    mkdir \$dir
fi
cd \$dir
touch Hostname
cat \$PBS_NODEFILE >> Hostname

mkdir -p  /scratch/$USER/\${j}
cd  /scratch/$USER/\${j}

#copy files and program to nod
cp \${CURRDIR}/*  ./

### begin STAT
echo "date's_format +%Y/%m/%d/%H/%M" > ./STAT
echo "nod_num="\${PBS_NODENUM} >> ./STAT
echo "task_num="\${PBS_TASKNUM} >> ./STAT
echo "memory(MB)="\${mem} >> ./STAT
echo "nod's_name="`hostname` >> ./STAT
echo "user="$USER >> ./STAT
echo "begin_task="`date +%Y/%m/%d/%H/%M` >> ./STAT

#here I'm running my program
$MY_PROGRAM \${l}

echo "end_task="`date +%Y/%m/%d/%H/%M` >> ./STAT
### end STAT

cd /scratch/$USER
zip -r \${j}.zip \${j}
cd \${CURRDIR}

#check connection with server

while ! ping -c1 klaster.bt.uwr > /dev/null;
do
    echo "Cluster unreachable :( waiting...";
    sleep 1000;
done;

#copy data from nod to server

cp -r -p /scratch/$USER/\${j}.zip ./

#remove data from nod

rm -r /scratch/$USER/\${j} 
rm /scratch/$USER/\${j}.zip 

EOF
