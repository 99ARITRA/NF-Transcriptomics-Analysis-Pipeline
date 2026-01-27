process MAPPER {
    tag "miRNA SAMPLE >> $(meta.id)"

    input:
    tuple val(meta), path(fastqpath)

    output:
    tuple val(meta), path("${meta.id}.fa"), emit: mapper_out
    
    script:
    """
    mapper.pl -e -h -i -j -l 18 -m -p ${params.ref} -s ${meta.id}.fa -v -n
    """
}

process QUANTIFIER {
    tag "mRNA SAMPLE >> $(meta.id)"
    publishDir "WTS/mirdeep2_output", mode: 'copy', pattern: "*.{csv|html}"
    
    input:
    tuple val(meta), path(mapper_out)
    
    output:
    tuple val(meta), path("${meta.id}_miRNA_expressions.csv"), emit: quantifier_out
    tuple val(meta), path("${meta.id}_miRNA_expressions.html"), emit: html_out
    
    script:
    """
    quantifier.pl -p ${params.precursor} -m ${params.mature} -r ${mapper_out} -s ${params.star} -d -j
    """
}
