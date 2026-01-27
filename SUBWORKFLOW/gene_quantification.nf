include { HISAT2 } from '../MODULES/hisat2.nf'
include { QUALIMAP } from '../MODULES/qualimap.nf'
include { FEATURECOUNTS} from '../MODULES/featurecounts.nf'

workflow MAPPING {
take:
trimmed_ch   

main:
HISAT2(trimmed_ch)
bam_ch = HISAT2.out.bam
map_stats_ch = HISAT2.out.hisat2_summary

QUALIMAP(bam_ch)
qmap_ch = QUALIMAP.out.qualimap_report_dir

emit:
bam_ch
map_stats_ch
qmap_ch
}

workflow QUANTIFICATION {
take:
mapped_ch   

main:
FEATURECOUNTS(mapped_ch)
readcounts_ch = FEATURECOUNTS.out.gene_counts

emit:
readcounts_ch
}