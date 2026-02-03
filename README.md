# NF-Transcriptomics-Analysis-Pipeline
A nextflow pipeline for the analysis of RNAseq data
## Installation steps
  1. Check java version (required Java 17) `java -version`
  2. Install and set up nextflow
     `curl -s https://get.nextflow.io | bash
     chmod +x nextflow
     mkdir -p $HOME/.local/bin/
     mv nextflow $HOME/.local/bin/`
  3. Install conda and docker.
  4. Fetch the repository `git clone  
## Pipeline execution
To execute the pipeline in a Linux terminal or WSL type the command:
`nextflow run -C rnaseq.config rnaseq.nf -params-file params.json`
