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

(i) Prodigal x 14 

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

```
Output = GCF_000006745.1_ASM674v1_genomic : 3594 genes
```

```
Output =
GCF_000006745.1_ASM674v1_genomic 3594
GCF_000006825.1_ASM682v1_genomic 2032
GCF_000006865.1_ASM686v1_genomic 2383
GCF_000007125.1_ASM712v1_genomic 3152
GCF_000008525.1_ASM852v1_genomic 1579
GCF_000008545.1_ASM854v1_genomic 1866
GCF_000008565.1_ASM856v1_genomic 3248
GCF_000008605.1_ASM860v1_genomic 1009
GCF_000008625.1_ASM862v1_genomic 1776
GCF_000008725.1_ASM872v1_genomic 897
GCF_000008745.1_ASM874v1_genomic 1063
GCF_000008785.1_ASM878v1_genomic 1505
GCF_000027305.1_ASM2730v1_genomic 1748
GCF_000091085.2_ASM9108v2_genomic 1057 
```

## 4

commands:

```
touch forloop_prokka.sh
nano forloop_prokka.sh
chmod +x forloop_prokka.sh
./forloop_prokka.sh
```

(i) Prokka x 14 + CDS 

```
touch forloop_prokka.sh
nano forloop_prokka.sh
chmod +x forloop_prokka.sh
```

for loop script: 

```
base_dir="/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data"
output_dir="/home/masom0b/ncbi_dataset/last_week/prokka"

mkdir -p "$output_dir"

results_file="$output_dir/prokka_results.txt"
> "$results_file"

for dir in "$base_dir"/*/; do
    fna_files=($(find "$dir" -name "*GCF*.fna"))

    if [[ ${#fna_files[@]} -eq 0 ]]; then
        echo "No .fna files found in $dir"
        continue
    fi

    for fna_file in "${fna_files[@]}"; do
        base_name=$(basename "$fna_file" .fna)

        prokka_output_dir="$output_dir/${base_name}_prokka_output"

        prokka --outdir "$prokka_output_dir" --prefix "$base_name" --force "$fna_file" --quiet

        gff_file="$prokka_output_dir/${base_name}.gff"

        if [[ ! -f "$gff_file" ]]; then
            echo "Prokka failed for $fna_file" >> "$results_file"
            continue
        fi

        cds_count=$(grep -c $'\tCDS\t' "$gff_file")

        echo "Genome: $base_name" >> "$results_file"
        echo "CDS count: $cds_count" >> "$results_file"
        echo "" >> "$results_file"
    done
done

echo "CDS counts have been saved to $results_file"

```
```
Output = prokka_results.txt - Max CDS Count ( CF_000006745.1/GCF_000006745.1_ASM674v1_genomic.fna : 3589 )
```
CDS COUNTS ALL:

```
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000007125.1/GCF_000007125.1_ASM712v1_genomic.fna: 3150
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008545.1/GCF_000008545.1_ASM854v1_genomic.fna: 1861
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008565.1/GCF_000008565.1_ASM856v1_genomic.fna: 3245
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008625.1/GCF_000008625.1_ASM862v1_genomic.fna: 1771
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008725.1/GCF_000008725.1_ASM872v1_genomic.fna: 892
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000006745.1/GCF_000006745.1_ASM674v1_genomic.fna: 3589
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000006825.1/GCF_000006825.1_ASM682v1_genomic.fna: 2028
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000006865.1/GCF_000006865.1_ASM686v1_genomic.fna: 2383
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008605.1/GCF_000008605.1_ASM860v1_genomic.fna: 1001
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008785.1/GCF_000008785.1_ASM878v1_genomic.fna: 1504
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008525.1/GCF_000008525.1_ASM852v1_genomic.fna: 1577
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000008745.1/GCF_000008745.1_ASM874v1_genomic.fna: 1058
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000027305.1/GCF_000027305.1_ASM2730v1_genomic.fna: 1748
/home/masom0b/ncbi_dataset/last_week/ncbi_dataset/data/GCF_000091085.2/GCF_000091085.2_ASM9108v2_genomic.fna: 1052

```

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

Prokka actually used Prodigal and the number of genes were slightly different.
prokka: Comprehensive genome annotation Annotates CDS, tRNAs, rRNAs, pseudogenes, and non-coding elements Functional annotation using databases ; takes a lot more time to run and has more filters.
prodigal: CDS oriented only

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

## 6 CRISPR CAS FINDER (BONUS)

```
gitclone https://github.com/dcouvin/CRISPRCasFinder
load module perl #Maxat helped me here
nano forloop.sh
chmod +x forloopcas.sh
```

for all 28
```
 ./forloopcas.sh
```
looped command 

```
perl "$crisprcasfinder_dir/CRISPRCasFinder.pl" -in "$fna_file" -out "$crispr_output_dir" -cas -drpt #chatgpt3.5 was used to find the command #I did this with perl5 too after installing it
```
Code of forloopcas.sh: 

```
base_dir="/home/masom0b/files_for_tool/ncbi_dataset/data"
output_dir="/home/masom0b/outputscrisprforloop"
crisprcasfinder_dir="/home/masom0b/CRISPRCasFinder"
perl5_lib="/home/masom0b/perl5"

mkdir -p "$output_dir"

results_file="$output_dir/crispr_array_counts.tsv"
> "$results_file"

for dir in "$base_dir"/*/; do
    fna_file=$(find "$dir" -name "*.fna")

    if [[ -f "$fna_file" ]]; then
        base_name=$(basename "$fna_file" .fna)

        crispr_output_dir="$output_dir/${base_name}_crispr_output"
        mkdir -p "$crispr_output_dir"

        perl "$crisprcasfinder_dir/CRISPRCasFinder.pl" -in "$fna_file" -out "$crispr_output_dir" -cas -drpt > crispr_summary_file="$crispr_output_dir/CRISPR-Cas_summary.txt" #ChatGPT 3.5 was used to ask the correct syntax of the perl command
        if [[ -f "$crispr_summary_file" ]]; then
            num_crispr=$(grep -c "CRISPR" "$crispr_summary_file")
        else
            num_crispr=0 #Chatgp 3.5 was used to debug my code here
        fi

        echo -e "$base_name\t$num_crispr" >> "$results_file"
    fi
done

echo "CRISPR array identification completed. Results saved to $results_file"

```
Command to view it 
```
cd prokka_output_CDS/
ls
```

Output = cat /home/masom0b/outputscrisprforloop/crispr_array_counts.tsv

```
GCA_000006745.1_ASM674v1_genomic        0
GCA_000006825.1_ASM682v1_genomic        0
GCA_000006865.1_ASM686v1_genomic        0
GCA_000007125.1_ASM712v1_genomic        0
GCA_000008525.1_ASM852v1_genomic        0
GCA_000008545.1_ASM854v1_genomic        0
GCA_000008565.1_ASM856v1_genomic        0
GCA_000008605.1_ASM860v1_genomic        0
GCA_000008625.1_ASM862v1_genomic        0
GCA_000008725.1_ASM872v1_genomic        0
GCA_000008745.1_ASM874v1_genomic        0
GCA_000008785.1_ASM878v1_genomic        0
GCA_000027305.1_ASM2730v1_genomic       0
GCA_000091085.2_ASM9108v2_genomic       0
GCF_000006745.1_ASM674v1_genomic        0
GCF_000006825.1_ASM682v1_genomic        0
GCF_000006865.1_ASM686v1_genomic        0
GCF_000007125.1_ASM712v1_genomic        0
GCF_000008525.1_ASM852v1_genomic        0
GCF_000008545.1_ASM854v1_genomic        0
GCF_000008565.1_ASM856v1_genomic        0
GCF_000008605.1_ASM860v1_genomic        0
GCF_000008625.1_ASM862v1_genomic        0
GCF_000008725.1_ASM872v1_genomic        0
GCF_000008745.1_ASM874v1_genomic        0
GCF_000008785.1_ASM878v1_genomic        0
GCF_000027305.1_ASM2730v1_genomic       0
GCF_000091085.2_ASM9108v2_genomic       0

```

It was also tested on these 14 genomes via Prokka but it gave me a different answer such that 8545.1 had 11 CRISPR arrays while 5825.1 gave me 12 and 0625.1 gave me 9. Maybe the criteria for this tool is much more intense and with more filters.
I checked with some online tools and got zero too in all.

```
grep -c "CRISPR" prokka_output/*/*.gff
```
