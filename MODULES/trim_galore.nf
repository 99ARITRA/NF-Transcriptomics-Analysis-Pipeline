process TRIMGALORE {
    tag "PROJECT ($meta.project) SAMPLE : $meta.sample"
    cpus 2
    memory 1.GB
    maxForks 3
    // publishDir "params.outDir/$meta.project/fastqc_reports", mode: 'copy'
    // publishDir "$params.outDir/$meta.project/trimmed_files", mode: 'copy', pattern: "*.{fq.gz}"
    publishDir "$params.outDir/$meta.project/QCreports", mode: 'copy', pattern: "*.{html, zip, txt}"

    input:
    tuple val(meta), path(fq1), path(fq2)
    
    output:
    tuple val(meta), path("${meta.sample}_1_val_1.fq.gz"), emit: trimmed_fq1
    tuple val(meta), path("${meta.sample}_2_val_2.fq.gz"), emit: trimmed_fq2
    tuple val(meta), path("*.html"), emit: trimmed_html
    tuple val(meta), path("*.zip"), emit: trimmed_zip
    tuple val(meta), path ("*_trimming_report.txt"), emit: trimming_reports
    
    script:
    """
    trim_galore -j ${task.cpus} --fastqc --trim-n --polyA --paired $fq1 $fq2
    """
}