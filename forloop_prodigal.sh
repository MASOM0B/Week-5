base_dir="/home/masom0b/ncbi_dataset/week_5/ncbi_dataset/data"
output_dir="/home/masom0b/ncbi_dataset/week_5/outputs"

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



