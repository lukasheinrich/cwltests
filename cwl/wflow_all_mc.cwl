#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  nevents:
    type: int[]
  mcnames:
    type: string[]
  mcweights:
    type: float[]
  shapevars:
    type: string[]
    default: [ shape_conv_up,shape_conv_dn ]
  weightvariations:
    type: string[]
    default:
      - nominal
      - weight_var1_up
      - weight_var1_dn

outputs:
  merged:
    type: File
    outputSource: merge/merged

steps:
  run_mc:
    run: workflow_mc.cwl
    in:
      nevents: nevents
      mcname: mcnames
      mcweight: mcweights
      weightvariations: weightvariations
      shapevars: shapevars
    scatter: [ mcname, mcweight ]
    scatterMethod: dotproduct
    out: [ merged ]

  merge:
    run: merge.cwl
    in: 
      histograms: run_mc/merged
    out: [merged]

