#!/usr/bin/env nextflow

workflow  {
    main:
    ch_datasheet = channel.fromPath("./data/datasheet.csv")

}
