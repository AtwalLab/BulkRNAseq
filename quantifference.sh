
echo '.........................................'
echo '==Welcome to Quantifference=='
echo '.........................................'

mkdir output
cd output
mkdir kallisto
cd ..

echo "Is the expression matrix available (y/n) :"
read matrix

echo "Do you want to perform batch correction (y/n) :"
read batch

if [ $matrix = 'n' ]
then

echo "Type the fragment length :"
read len

echo "Type the fragment length uncertainty :"
read delta_len

echo "Type the number of bootstraps (100 recommended) :"
read bootstrap

echo "Type the number of threads (4 recommended) :"
read thread

echo "Is the reference genome index .idx available (y/n) :"
read index

echo "Do you want to run differential analysis afterwards (y/n) :"
read diff

echo '.........................................'
echo '==Start Kallisto Quantification=='
echo '.........................................'

if [ $index = 'n' ]
then

kallisto index -i transcripts.idx *.fasta.gz

for file in *.fastq.gz
do
outname=$(echo $file | sed 's/.fastq.gz/.abundance/' )
time kallisto quant --single -b $bootstrap --seed 42 --bias --rf-stranded -i *.idx -o output/kallisto/$outname -l $len -s $delta_len -t $thread $file
done

else

for file in *.fastq.gz
do
outname=$(echo $file | sed 's/.fastq.gz/.abundance/' )
time kallisto quant --single -b $bootstrap --seed 42 --bias --rf-stranded -i *.idx -o output/kallisto/$outname -l $len -s $delta_len -t $thread $file
done

fi

Rscript expression_matrix.R

echo '.........................................'
echo '==Transcript Quantification is Finished=='
echo '.........................................'

if [ $diff = 'y']
then

echo '.........................................'
echo '==Start Sleuth Differential Analysis=='
echo '.........................................'

time Rscript sleuth_analysis.R

echo '.........................................'
echo '==Differential Analysis is Finished=='
echo '.........................................'

else

echo '.........................................'
echo '==Continue to other downstream analysis=='
echo '.........................................'

fi

fi

if [ $batch = 'y' ]
then

echo '.........................................'
echo '==Start ComBat Batch Correction=='
echo '.........................................'

Rscript combat.R

echo '.........................................'
echo '==Batch Correction is Finished=='
echo '.........................................'

else

echo '.........................................'
echo '==Continue to other downstream analysis=='
echo '.........................................'

fi
