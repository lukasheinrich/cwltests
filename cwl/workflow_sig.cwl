#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}

inputs:
  nevents:
    type: int[]
  mcweight:
    type: float

outputs:
  merged:
    type: File
    outputSource: select_hist/histogram

steps:
  read:
    run: generate.cwl
    in:
      type: { default: sig }
      nevents: nevents
    scatter: nevents
    out: [ events ]

  merge:
    run: merge.cwl
    in: 
      histograms: read/events
    out: [merged]

  select:
    run: select.cwl
    in:
      inputfile: merge/merged
      region: { default: signal }
      variations: { default: [ nominal ] }
    out: [ outputfile ] 

  #select_merge:
  #  run: merge.cwl
  #  in: {}
  #  out: []

  select_hist:
    run: histogram.cwl
    in:
      inputfile: select/outputfile
      name: { default: signal }
      weight: mcweight
      variations: { default: [ nominal ] }
    out: [histogram]

  #hist_merge:
  #  run: merge.cwl
  #  in:
  #    histograms: select_hist/histogram
  #  out: [merged]
