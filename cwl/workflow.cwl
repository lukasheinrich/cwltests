#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

inputs:
  events: int
outputs:
  hepmc:
    type: File
    outputSource: showering/hepmc

steps:
  parameter_definition:
    run: prep.tool
    in:
      model: {default: sm}
    out: [parameter_card]
  event_generation:
    run: madgraph.tool
    in:
      paramcard: parameter_definition/parameter_card
      events: events
    out: [leshouchesevents]
  showering:
    run: pythia.tool
    in:
      lhefile: event_generation/leshouchesevents
      events: events
    out: [hepmc]
