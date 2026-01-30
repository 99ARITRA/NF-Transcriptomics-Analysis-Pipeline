process HISAT2_INDEX {
    tag "GENOME: $params.genome"
    cpus 6
    
    input:
    path(genome)

    output:
    path("ht2_index.*"), emit: ht2_indexes

    script:
    """
    hisat2-build -p $task.cpus $genome ht2_index
    """
}

process HISAT2_ALIGN {
    tag "PROJECT ($meta.project) SAMPLE : $meta.sample"
    cpus 5
    // memory 3.GB
    maxForks 1
    publishDir "$params.outDir/$meta.project/mapped_files", mode: 'copy', pattern: "*.{txt}"
    
    input:
    tuple val(meta), path(trimmed_fq1), path(trimmed_fq2)
    path(ht2_indexes)

    output:
    tuple val(meta), path("${meta.sample}_${meta.type}.sam"), emit: sam
    tuple val(meta), path("${meta.sample}_${meta.type}_summary.txt"), emit: hisat2_summary

    script:
    """
    hisat2 -p $task.cpus -x ht2_index -1 ${trimmed_fq1} -2 ${trimmed_fq2} --summary-file ${meta.sample}_${meta.type}_summary.txt -S ${meta.sample}_${meta.type}.sam 
    """
}

process SAMTOOLS_SORT {
    tag "PROJECT ($meta.project) SAMPLE : $meta.sample"
    cpus 2
    // memory 2.GB
    maxForks 1
    publishDir "$params.outDir/$meta.project/mapped_files", mode: 'copy', pattern: "*.{bam}"
    
    input:
    tuple val(meta), path(sam)

    output:
    tuple val(meta), path("${meta.sample}_${meta.type}.bam"), emit: bam

    script:
    """
    samtools sort -@ $task.cpus -o ${meta.sample}_${meta.type}.bam ${sam}
    """
}