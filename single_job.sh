#!/bin/bash
cat <<EOF | qsub -r n
#!/bin/bash --login
#PBS -q normal
#PBS -l mem=1000MB
#PBS -l nodes=1:ppn=1
#PBS -N $1
#PBS -M $USER

export CURRDIR=`pwd`

j=SIMULATION${1}

mkdir -p  /scratch/$USER/\${j}
cd  /scratch/$USER/\${j}
cp \${CURRDIR}/quipt_test.R  ./

hostname > ./hostname 

R -e 'source("quipt_test.R")'
cd ..
cp -r  \${j} \${CURRDIR}
cd \${CURRDIR}
rm -r /scratch/$USER/\${j} 

EOF
