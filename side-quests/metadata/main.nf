#!/usr/bin/env nextflow

workflow  {
    main:
    ch_datasheet = channel.fromPath("./data/datasheet.csv")

    publish:
    cowpy_art = channel.empty()
}

output {
    cowpy_art {
    }
}
