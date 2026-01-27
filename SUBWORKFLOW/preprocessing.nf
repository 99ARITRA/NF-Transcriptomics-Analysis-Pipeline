include { FASTQC } from '../MODULES/fastqc.nf'
include { TRIMGALORE } from '../MODULES/trim_galore.nf'

// PREPROCESSING WORKFLOW >> Outputs QC and trimming files
workflow  PREPROCESSING {
    take:
        rna_channel
    main:

        FASTQC(rna_channel)
        raw_html_ch = FASTQC.out.raw_html
        raw_zip_ch = FASTQC.out.raw_zip
        fastqc_ch = raw_html_ch.join(raw_zip_ch, by: 0) 

        TRIMGALORE(rna_channel)
        trimmedfq1_ch = TRIMGALORE.out.trimmed_fq1
        trimmedfq2_ch =  TRIMGALORE.out.trimmed_fq2
        trimmed_html_ch = TRIMGALORE.out.trimmed_html
        trimmed_zip_ch= TRIMGALORE.out.trimmed_zip

    emit:
        fastqc_ch
        trimmedfq1_ch
        trimmedfq2_ch
        trimmed_html_ch
        trimmed_zip_ch
}