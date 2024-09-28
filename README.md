# Week-5: Genome Annotation 

## 1: Number of Aminoacids and Bases in a given sequence

(i) Amino acid count excluding the stop codon 

```
aa_sequence_no_gap = aa_sequence.replace("-", "")

num_amino_acids = len(aa_sequence_no_gap) - 1

print(num_amino_acids)

```

Output = 

(ii) Bases count including the stop codon

```
aa_sequence = "KVRMFTSELDIMLSVNG-PADQIKYFCRHWT*"

aa_sequence_no_gap = aa_sequence.replace("-", "")

num_bases = (num_amino_acids + 1) * 3  # +1 to include stop codon

print(num_bases)

```

Output =

## 2:

(i)  Prodigal on 1 downloaded genome

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
