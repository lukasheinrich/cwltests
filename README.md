
cwl: 

    cwltool --no-match-user --no-read-only workflow.cwl --events 100

yad:

    yadage-run workdir madgraph_delphes.yml -p nevents=100
