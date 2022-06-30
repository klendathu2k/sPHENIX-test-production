## SHREK Inputs
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/simple-chain/bottom.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/simple-chain/top.yaml
## Generated scripts
- bottom.sh
- top.sh
## Job resources
- none
## Job dependencies
![Workflow graph](workflow.png)
- bottom
  inputs:
  - top/outDS

  outputs:
  - bottom/outDS
- top

  outputs:
  - top/outDS
## PanDA Monitoring
[panda monitoring](https://panda-doma.cern.ch/tasks/?taskname=user.jwebb2.simple-35826dc7-f882-11ec-b5ca-00163e101049_*)
