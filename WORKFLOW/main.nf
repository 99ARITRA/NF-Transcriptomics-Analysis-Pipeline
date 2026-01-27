include { PREPROCESSING } from '../SUBWORKFLOW/preprocessing.nf'
include { MAPPING } from '../SUBWORKFLOW/gene_quantification.nf'
include { QUANTIFICATION } from '../SUBWORKFLOW/gene_quantification.nf'


workflow RNASEQ_GENES {

    ss_channel = channel.fromPath(params.rna_samplesheet).splitCsv(header:true)
                                    .map {
            row -> def meta = [
                project: row.PROJECT,
                sample: row.SAMPLE,
                type: row.TYPE
            ] 
            return [meta, file(row.R1), file(row.R2)]   
                                    }

    PREPROCESSING(ss_channel)

    mrna_channel = PREPROCESSING.out.trimmedfq1_ch
                    .join(PREPROCESSING.out.trimmedfq2_ch, by: 0)

    MAPPING(mrna_channel)

    // mapped_ch = MAPPING.out.bam_ch
    //                         .first()
    //                     .map { 
    //                         meta, bam -> bam }
    //                     .collect()
    //                     .combine(MAPPING.out.bam_ch
    //                             .first()
    //                     .map { meta, bam -> meta.project })
    //                     .map { bams,project -> def meta2 = []
    //                         meta2 = [project: project]
    //                         return [meta2, bams]
    //                         }

    mapped_ch = MAPPING.out.bam_ch
                        .map { meta, bam -> [meta.project, bam] }
                        .groupTuple(by: 0)
                        .map { project, bams ->
                            def meta2 = [project: project]
                            return [meta2, bams]
                            }

    QUANTIFICATION(mapped_ch)
}
