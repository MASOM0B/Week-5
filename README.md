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
run command: python3 aa.py
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
command = python3 bases.py

Output = 93

## 2:

(i)  Prodigal on 1 downloaded genome

E.coli from Ibex --> Home Directory

cd /ibex/scratch/hohndor/bioe-2024/e.coli/GCA_000005845.2
cp -r /ibex/scratch/hohndor/bioe-2024/e.coli/GCA_000005845.2 /home/masom0b/ncbi_dataset/week_5

```

module load prodigal/2.6.3
prodigal -i /home/masom0b/ncbi_dataset/week_5/ncbi_dataset/data/GCA_000006745.1/GCF_000006745.1_ASM674v1_genomic.fna
 -o output.gbk -d output.fna


```

Output = 

(ii) Max Gene Count Strain

```
grep ">" output.fna > howmanygenes.txt
```

Output =

## 3

(i) Prodigal x 28 

```

```

Output =

(ii) Max Gene Count Strain 

```

```

Output =

(iii) README.md

```

```

Output =

## 4

(i) Prokka x 28

```

```

Output =

(ii) CDS Count

```

```

Output =

(iii) Thoughts on differences

```

```

Output =

## 5

(i) Unique gene names

```

```

Output =

(ii) First 5 unique gene names

```

```

Output =

## 6 CRISPR CAS FINDER

(i) Download

```

```

Output =

(ii) Install


```

```

Output =

(iii) How many Arrays in a tabular fashion 

```

```

Output =
