# NF-Transcriptomics-Analysis-Pipeline
A nextflow pipeline for the analysis of RNAseq data
## Tools used
  1. FASTQC
  2. TRIM-GALORE
  3. HISAT2
  4. SAMTOOLS
  5. FEATURECOUNTS
## Installation steps
  1. Check java version (required Java 17) `java -version`
  2. Install and set up nextflow
     `curl -s https://get.nextflow.io | bash \n
     chmod +x nextflow \n
     mkdir -p $HOME/.local/bin/ \n
     mv nextflow $HOME/.local/bin/`
  4. Install conda and Docker.
  5. Fetch the repository `git clone https://github.com/99ARITRA/NF-Transcriptomics-Analysis-Pipeline.git`
  6. Run the pipeline as per "pipeline execution".
  7. Change the config and params.json file as per requirement.
## Pipeline execution
To execute the pipeline in a Linux terminal or WSL type the command:
`nextflow run -C rnaseq.config rnaseq.nf -params-file params.json`
