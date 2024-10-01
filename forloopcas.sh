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

        perl "$crisprcasfinder_dir/CRISPRCasFinder.pl" -in "$fna_file" -out "$crispr_output_dir" -cas -drpt #ChatGPT 3.5 was used to ask the correct syntax of the perl command beacuse I wa>
        crispr_summary_file="$crispr_output_dir/CRISPR-Cas_summary.txt"
        if [[ -f "$crispr_summary_file" ]]; then
            num_crispr=$(grep -c "CRISPR" "$crispr_summary_file")
        else
            num_crispr=0 #Chatgp 3.5 was used to debug my code here
        fi

        echo -e "$base_name\t$num_crispr" >> "$results_file"
    fi
done

echo "CRISPR array identification completed. Results saved to $results_file"