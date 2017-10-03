
[![Visualization](https://view.commonwl.org/graph/png/github.com/lukasheinrich/cwltests/blob/master/cwl/workflow.cwl)](https://view.commonwl.org/workflows/github.com/lukasheinrich/cwltests/blob/master/cwl/workflow.cwl)


![Visualization](yadage/yadviz.png)

cwl: 

    cwltool --no-match-user --no-read-only workflow.cwl --events 100

yad:

    yadage-run workdir madgraph_delphes.yml -p nevents=100
