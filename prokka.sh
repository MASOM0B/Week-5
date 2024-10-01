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