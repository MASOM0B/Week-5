# Week-5: Genome Annotation 

## 1: Number of Aminoacids and Bases in a given sequence

(i) Amino acid count excluding the stop codon 

Python Code:

```
def aa(aa_sequence):
    aa_sequence_no_gap = aa_sequence.replace("-", "")
    num_amino_acids = len(aa_sequence_no_gap) - 1
    print(num_amino_acids)

aa_sequence = "KVRMFTSELDIMLSVNG-PADQIKYFCRHWT*"
aa(aa_sequence)

```
run command: 


```
python3 aa.py
```

Output = 30

(ii) Bases count including the stop codon

Python Code:

```
def bases(aa_sequence):
    aa_sequence_no_gap = aa_sequence.replace("-", "")
    num_amino_acids = len(aa_sequence_no_gap) - 1
    num_bases = (num_amino_acids + 1) * 3
    print(num_bases)

aa_sequence = "KVRMFTSELDIMLSVNG-PADQIKYFCRHWT*"
bases(aa_sequence)
```
command: 
```
python3 bases.py
```

Output = 93

## 2:

(i)  Prodigal on 1 downloaded genome


```
module load prodigal/2.6.3

prodigal -i GCA_000006865.1_ASM686v1_genomic.fna -o prodigal_output.gbk -a prodigal_output.faa -d prodigal_output.ffn
```

Output:
```
prodigal_output.faa  prodigal_output.ffn  prodigal_output.gbk files  
```

(ii) Max Gene Count Strain

Command:

Using bash commands on the output file, we can get the max genes.

```
grep -c ">" prodigal_output.ffn
```

Output = 2383

## 3

(i) Prodigal x 28 

Commands to initiate the prodigal loop file

```
touch forloop_prodigal.sh
nano forloop_prodigal.sh
chmod +x forloop_prodigal.sh
./forloop_prodigal.sh

```
for loop script code 

```
base_dir="/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data"
output_dir="/home/masom0b/ncbi_dataset/last_week/outputs"

mkdir -p "$output_dir"

gene_counts_file="$output_dir/gene_counts.txt"
> "$gene_counts_file"

for dir in "$base_dir"/*/; do
    fna_file=$(find "$dir" -name "*GCF*.fna")

    if [[ -f "$fna_file" ]]; then
        base_name=$(basename "$fna_file" .fna)

        gbk_output_file="$output_dir/${base_name}_prodigal_output.gbk"
        faa_output_file="$output_dir/${base_name}_prodigal_output.faa"
        ffn_output_file="$output_dir/${base_name}_prodigal_output.ffn"

        prodigal -i "$fna_file" -o "$gbk_output_file" -a "$faa_output_file" -d "$ffn_output_file"

        num_genes=$(grep -c ">" "$ffn_output_file")

        echo "$base_name $num_genes" >> "$gene_counts_file"
    fi
done

max_genome=$(sort -k2 -nr "$gene_counts_file" | head -n 1 | awk '{print $1}')
max_genes=$(sort -k2 -nr "$gene_counts_file" | head -n 1 | awk '{print $2}')

echo "$max_genome : $max_genes genes" | tee "$output_dir/max_genes_genome.txt"
```

command:
```
chmod +x forloop_prodigal.sh
./forloop_prodigal.sh
```

Output = GCF_000006745.1_ASM674v1_genomic : 3594 genes

git push: 
git add 
git commit -m name
git push 

## 4
commands:
```
touch forloop_prokka.sh
nano forloop_prokka.sh
chmod +x forloop_prokka.sh
./forloop_prokka.sh
```

(i) Prokka x 28 + CDS 

```
touch forloop_prokka.sh
nano forloop_prokka.sh
chmod +x forloop_prokka.sh
```

forloop script: 

```
base_dir="/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data"
output_dir="/home/masom0b/ncbi_dataset/last_week/prokka_output_CDS"

mkdir -p "$output_dir"

results_file="$output_dir/prokka_results.txt"
> "$results_file"

for dir in "$base_dir"/*/; do
    fna_file=$(find "$dir" -name "*GCF*.fna")

    if [[ -f "$fna_file" ]]; then
        base_name=$(basename "$fna_file" .fna)

        prokka_output_dir="$output_dir/${base_name}_prokka_output"

        prokka --outdir "$prokka_output_dir" --prefix "$base_name" --force "$fna_file" --quiet

        gff_file="$prokka_output_dir/${base_name}.gff"
        cds_count=$(grep -c "ID=" "$gff_file")

        echo "Genome: $base_name" >> "$results_file"
        echo "CDS count: $cds_count" >> "$results_file"
        echo "" >> "$results_file"
    fi
done

echo "CDS counts have been saved to $results_file"
```
Output = prokka_results.txt

(ii) Thoughts on differences

Prodigal Output Files:
```
.gbk
.faa
.ffn
```

Prokka Output Files:

```
.gff
.gbk
.faa
.ffn
.fna
.txt
.sqn
```

And I noticed that Prokka actually used Prodigal and the number of genes were slightly different 
prokka: Comprehensive genome annotation Annotates CDS, tRNAs, rRNAs, pseudogenes, and non-coding elements Functional annotation using databases ; takes a lot more time to run
prodigal: CDS oriented 

## 5

(i) Unique gene names

Command:

```
grep -h "gene=" /home/masom0b/ncbi_dataset/last_week/prokka_output_CDS/*/*.gff | sed 's/.*gene=//' | sed 's/;.*//' | sort | uniq > unique_gene_names.txt

```

Output = unique_gene_names.txt


(ii) First 5 unique gene names from all .gff made after I ran Prokka 

Command:
```
head -n 5 unique_gene_names.txt
```

Output = 
```
aaaT
aaeA
aaeA_1
aaeA_2
aaeB
```

## 6 CRISPR CAS FINDER

gitclone
cd CRISPR

(i) Download
anaconda
C:\Users\PTCL\Desktop\1st_sem\BioE230\week_5 both here
https://www.anaconda.com/download?utm_source=anacondadoc&utm_medium=documentation&utm_campaign=download&utm_content=topnavalldocs
installed in users bcz space
powershell of anaconda
cd C:\Users\PTCL\Desktop\1st_sem\BioE230\week_5
conda create --prefix ./myenv python=3.9
conda activate ./myenv
conda install numpy pandas biopython
conda install jupyter
python crispr.py
jupyter notebook
(C:\Users\PTCL\Desktop\1st_sem\BioE230\Week_5\myenv) PS C:\Users\PTCL\Desktop\1st_sem\BioE230\Week_5> conda config --add channels conda-forge
(C:\Users\PTCL\Desktop\1st_sem\BioE230\Week_5\myenv) PS C:\Users\PTCL\Desktop\1st_sem\BioE230\Week_5> conda config --add channels bioconda
conda install -c anaconda perl
conda install -c bioconda 
conda install perl-bio-semtools


cd WEEK 5
$env:Path += ";C:\Users\PTCL\Anaconda3;C:\Users\PTCL\Anaconda3\Scripts;C:\Users\PTCL\Anaconda3\condabin" #pathtemp
conda --verison
conda create --name bioe230 python=3.9
conda activate bioe230

```
[masom0b@login509-02-r CRISPRCasFinder]$ perl CRISPRCasFinder.pl -in install_test/sequence.fasta -cas -cf CasFinder-2.0.3 -def G -keep
Can't locate Bio/AlignIO.pm in @INC (you may need to install the Bio::AlignIO module) (@INC contains: /usr/local/lib64/perl5/5.32 /usr/local/share/perl5/5.32 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5) at CRISPRCasFinder.pl line 30.
BEGIN failed--compilation aborted at CRISPRCasFinder.pl line 30.
```

I was getting a message after running that I have some package missing and after installing it (took a long time), it said I needed linux and I couldn't figure that out on windows

```

```

Output =

