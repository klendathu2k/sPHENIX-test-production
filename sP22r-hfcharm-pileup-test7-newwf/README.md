## SHREK Inputs
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_charm-ana.315/runPileup.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_charm-ana.315/runCalorimeter.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_charm-ana.315/runPass3Track.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_charm-ana.315/runPass4TrackStage0.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_charm-ana.315/runPass4TrackStageA.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_charm-ana.315/runPass4TrackStageC.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_charm-ana.315/mergeOutputs.yaml
## Generated scripts
- Pythia8CharmPileup.sh
- Pythia8Calorimeter.sh
- Pythia8Pass3Track.sh
- Pythia8Pass4TrackStage0.sh
- Pythia8Pass4TrackStageA.sh
- Pythia8Pass4TrackStageC.sh
- mergeOutputs.sh
## Job resources
- none
## Job dependencies
![Workflow graph](workflow.png)
- Pythia8CharmPileup
  inputs:
  - Pythia8CharmSignal
  - Pythia8Background

  outputs:
  - Pythia8CharmPileup/outDS
- Pythia8Calorimeter
  inputs:
  - Pythia8CharmPileup/outDS

  outputs:
  - Pythia8Calorimeter/outDS
- Pythia8Pass3Track
  inputs:
  - Pythia8CharmPileup/outDS

  outputs:
  - Pythia8Pass3Track/outDS
- Pythia8Pass4TrackStage0
  inputs:
  - Pythia8Pass3Track/outDS

  outputs:
  - Pythia8Pass4TrackStage0/outDS
- Pythia8Pass4TrackStageA
  inputs:
  - Pythia8Pass4TrackStage0/outDS

  outputs:
  - Pythia8Pass4TrackStageA/outDS
- Pythia8Pass4TrackStageC
  inputs:
  - Pythia8Pass4TrackStageA/outDS

  outputs:
  - Pythia8Pass4TrackStageC/outDS
- mergeOutputs
  inputs:
  - Pythia8Calorimeter/outDS
  - Pythia8Pass4TrackStageC/outDS

  outputs:
  - Pythia8CharmOutput/outDS
## PanDA Monitoring
[panda monitoring](https://panda-doma.cern.ch/tasks/?taskname=user.jwebb2.sP22r-hfcharm-pileup-test7-newwf_*)
