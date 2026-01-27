process FEATURECOUNTS {
    tag "PROJECT : $meta.project"
    cpus 7
    // memory 3.GB
    maxForks 1
    publishDir "$params.outDir/$meta.project/count_files", mode: 'copy'

    input:
    tuple val(meta), path(bams)

    output:
    tuple val(meta), path("${meta.project}_readcounts.tsv"), emit: gene_counts

    script:
    """
    featureCounts -t exon -g gene_id  -T $task.cpus -p --countReadPairs -F 'GTF' -a $params.gtf \
        -o ${meta.project}_readcounts.tsv ${bams}
    """
}