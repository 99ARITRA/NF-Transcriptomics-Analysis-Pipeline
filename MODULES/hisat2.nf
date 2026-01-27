process HISAT2_INDEX {
    tag "GENOME: $params.fasta"
    cpus 4
    
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
    cpus 4
    // memory 3.GB
    maxForks 1
    publishDir "$params.outDir/$meta.project/mapped_files", mode: 'copy'
    
    input:
    tuple val(meta), path(trimmed_fq1), path(trimmed_fq2)

    output:
    tuple val(meta), path("${meta.sample}_${meta.type}.bam"), emit: bam
    tuple val(meta), path("${meta.sample}_${meta.type}_summary.txt"), emit: hisat2_summary

    script:
    """
    hisat2 -p $task.cpus -x $params.ht2_index -1 ${trimmed_fq1} -2 ${trimmed_fq2} --summary-file ${meta.sample}_${meta.type}_summary.txt | samtools view -@ $task.cpus -h -b -S - | \
    samtools sort --verbosity 4 -@ $task.cpus  -o ${meta.sample}_${meta.type}.bam
    """
}