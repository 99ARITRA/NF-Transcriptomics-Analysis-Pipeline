process QUALIMAP {
    tag "PROJECT ($meta.project) SAMPLE : $meta.sample"
    maxForks 1
    publishDir "$params.outDir/$meta.project/bamQC_reports", mode: 'copy'

    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta), path("${meta.sample}_qualimap_rnaseq_report"), emit: qualimap_report_dir

    script:
    """
    qualimap rnaseq -bam $bam -gtf $params.gtf  -outdir ${meta.sample}_qualimap_rnaseq_report -outformat PDF:HTML
    """
}