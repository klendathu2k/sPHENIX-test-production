## SHREK Inputs
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_threestep/runPileup.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_threestep/runPass3Track.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_threestep/runPass4Track.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_threestep/runCalorimeter.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/workflows/HF_pp200_threestep/mergeOutputs.yaml
## Generated scripts
- Pythia8CharmPileup.sh
- Pythia8Pass3Track.sh
- Pythia8Pass4Track.sh
- Pythia8Calorimeter.sh
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
- Pythia8Pass3Track
  inputs:
  - Pythia8CharmPileup/outDS

  outputs:
  - Pythia8Pass3Track/outDS
- Pythia8Pass4Track
  inputs:
  - Pythia8Pass3Track/outDS

  outputs:
  - Pythia8Pass4Track/outDS
- Pythia8Calorimeter
  inputs:
  - Pythia8CharmPileup/outDS

  outputs:
  - Pythia8Calorimeter/outDS
- mergeOutputs
  inputs:
  - Pythia8Calorimeter/outDS
  - Pythia8Pass4Track/outDS

  outputs:
  - Pythia8CharmOutput/outDS
## PanDA Monitoring
[panda monitoring](https://panda-doma.cern.ch/tasks/?taskname=user.jwebb2.sP22p-pileup20-test2_*)
