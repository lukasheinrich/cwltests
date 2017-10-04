#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}

inputs:
  nevents:
    type: int[]
    #default: [10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000]

outputs:
  merged:
    type: File
    outputSource: merge_all/merged

steps:
  read:
    run: generate.cwl
    in:
      type: { default: data }
      nevents: nevents
    scatter: nevents
    out: [ events ]

  merge:
    run: merge.cwl
    in: 
      histograms: read/events
    out: [merged]

  select_signal:
    run: select.cwl
    in:
      inputfile: merge/merged
      region: { default: signal }
      variations: { default: [ nominal ] }
    out: [ outputfile ] 

  select_control:
    run: select.cwl
    in:
      inputfile: merge/merged
      region: { default: control }
      variations: { default: [ nominal ] }
    out: [ outputfile ] 


  #select_merge:
  #  run: merge.cwl
  #  in: {}
  #  out: []

  select_signal_hist:
    run: histogram.cwl
    in:
      inputfile: select_signal/outputfile
      name: { default: data }
      weight: { default: 1.0 }
    out: [histogram]

  select_control_hist:
    run: histogram.cwl
    in:
      inputfile: select_control/outputfile
      name: { default: qcd }
      weight: { default: 0.1875 }
    out: [histogram]

  merge_all:
    run: merge.cwl
    in:
      histograms: [ select_signal_hist/histogram, select_control_hist/histogram ]
    out: [merged]

