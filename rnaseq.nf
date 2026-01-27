include { RNASEQ_GENES } from './WORKFLOW/main.nf'

nextflow.enable.dsl = 2

workflow {

def logo = '''
 _   _ _____     _____ ____      _    ____  
| \\ | |  ___|   |_   _|  _ \\    / \\  |  _ \\ 
|  \\| | |_ _____ | | | |_) |  / _ \\ | |_) |
| |\\  |  _|_____|| | |  _ <  / ___ \\|  __/ 
|_| \\_|_|        |_| |_| \\_\\/_/   \\_\\_|    

T R A N S C R I P T O M I C S   A N A L Y S I S   P I P E L I N E
'''

    println("\n* -------------------------------------------------- * ")
    println(logo)
    println("* -------------------------------------------------- * \n")
    println("* -------------------------------------------------- * ")
    println("   OUTPUT DIRECTORY : ${params.outDir}")               
    println("   GTF FILE         : ${params.gtf}")                    
    println("   HISAT2 INDEX     : ${params.ht2_index}")
    println("* -------------------------------------------------- *\n ")

    RNASEQ_GENES()
}
































