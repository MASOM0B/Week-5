base_dir="/home/masom0b/ncbi_dataset/week_5/ncbi_dataset/data"
output_dir="/home/masom0b/ncbi_dataset/week_5/prokka_output_CDS"

mkdir -p "$output_dir"

results_file="$output_dir/prokka_results.txt"
> "$results_file"

for dir in "$base_dir"/*/; do
    fna_file=$(find "$dir" -name "*GCF*.fna")

    if [[ -f "$fna_file" ]]; then
        base_name=$(basename "$fna_file" .fna)

        prokka_output_dir="$output_dir/${base_name}_prokka_output"

        # Annotate using Prokka or Prodigal (adjusted for Prodigal here)
        prokka --outdir "$prokka_output_dir" --prefix "$base_name" --force "$fna_file" --quiet

        gff_file="$prokka_output_dir/${base_name}.gff"
        # Adjust for Prodigal output: Count lines with CDS entries (look for 'ID=')
        cds_count=$(grep -c "ID=" "$gff_file")

        echo "Genome: $base_name" >> "$results_file"
        echo "CDS count: $cds_count" >> "$results_file"
        echo "" >> "$results_file"
    fi
done

echo "CDS counts have been saved to $results_file"

