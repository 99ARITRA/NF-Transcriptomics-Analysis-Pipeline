process FASTQC {
    tag "PROJECT ($meta.project) SAMPLE : $meta.sample"
    cpus 2
    memory 1.GB
    maxForks 3
    publishDir "$params.outDir/$meta.project/qc_reports", mode: 'copy', pattern: "*.{html, zip}"

    input:
    tuple val(meta), path(R1), path(R2)

    output:
    tuple val(meta), path("*.html"), emit: raw_html
    tuple val(meta), path("*.zip"), emit: raw_zip
    script:
    """
    fastqc -t ${task.cpus} $R1 $R2
    """

}
    