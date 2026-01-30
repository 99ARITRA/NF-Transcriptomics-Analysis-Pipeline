include { HISAT2_INDEX } from '../MODULES/hisat2.nf'
include { HISAT2_ALIGN } from '../MODULES/hisat2.nf'
include { SAMTOOLS_SORT } from '../MODULES/hisat2.nf'
include { QUALIMAP } from '../MODULES/qualimap.nf'
include { FEATURECOUNTS} from '../MODULES/featurecounts.nf'

workflow MAPPING {
take:
trimmed_ch   

main:
genome = file(params.genome)
HISAT2_INDEX(file(genome))
ht2_index_ch = HISAT2_INDEX.out.ht2_indexes

HISAT2_ALIGN(trimmed_ch, ht2_index_ch)
sam_ch = HISAT2_ALIGN.out.sam
map_stats_ch = HISAT2_ALIGN.out.hisat2_summary

SAMTOOLS_SORT(sam_ch)
bam_ch = SAMTOOLS_SORT.out.bam

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